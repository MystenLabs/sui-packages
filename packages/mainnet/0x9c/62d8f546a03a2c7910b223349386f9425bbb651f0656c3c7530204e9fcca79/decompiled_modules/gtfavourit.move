module 0x9c62d8f546a03a2c7910b223349386f9425bbb651f0656c3c7530204e9fcca79::gtfavourit {
    struct GTFAVOURIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFAVOURIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFAVOURIT>(arg0, 9, 0x1::string::utf8(b"GTFAVOURIT"), 0x1::string::utf8(b"Favourite"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/qTKZdr3aKV-kp_iv53B93RcFqmKzmYcQGwogOuYI4p_nuHboBPXzMKsQ7yI7blES3mIhNyNnmKsV0VHH5H1PcZQnlRY-7BKDlhNUmfMe41K5x4H3dAIG_zgkgpjsy9KjuF5amMvEOI2Yh8QAtXQTIHuhLx_FkX1kR_6uP8dsQQ6ooYYNBzKSjx376KrKalyPXleWo9ztqlf8d1etxlPYR8PQYVGUiGcGx6xKlU8dCsU7AMThZNXF-MzrlZ0w02nLQgytg5VbcecrJiAUGrRD69BoTo3Wo9PaUSMIz2OTHdSV9BGLXLbhuUua8LREHZYxiqhy_jS1AZC-TWNfwyD9kA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFAVOURIT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFAVOURIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

