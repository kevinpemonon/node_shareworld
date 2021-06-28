const fs = require("fs");
const path = require("path");
const PictureOffer = require("../models/PictureOffer");

module.exports = {
  async serviceGetAllPicturesByOffer(offerId) {
    const pictures = await PictureOffer.findAll({
      where: { offer_id: offerId },
    });
    return pictures;
  },

  async serviceGetFile(name, res) {
    console.log("SERVICE GETFILE");
    await res.sendFile(
      path.join(__dirname, "../../uploads/offers/" + name),
      (err) => {
        if (err) {
          console.log("ERROR");
        } else {
          console.log("OK");
        }
      }
    );
    // return file;
  },

  async serviceCreatePicture(offerId, image) {
    if (offerId && image) {
      const pictures = await PictureOffer.findAll({
        where: { offer_id: offerId },
      });
      if (pictures.length < 3) {
        const createPicture = await PictureOffer.create({
          name: image.originalname,
          url: `offers/${image.filename}`,
          offer_id: offerId,
        });
        return createPicture;
      } else {
        return null;
      }
    }
  },

  async serviceDeletePicture(id) {
    const currentPicture = await PictureOffer.findOne({ where: { id: id } });
    if (currentPicture) {
      fs.unlinkSync(
        path.join(__dirname, "../../uploads/" + currentPicture.url)
      );
      PictureOffer.destroy({ where: { id: id } });
    }
  },
};
