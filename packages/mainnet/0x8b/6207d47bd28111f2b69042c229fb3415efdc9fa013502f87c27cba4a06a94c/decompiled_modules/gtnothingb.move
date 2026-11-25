module 0x8b6207d47bd28111f2b69042c229fb3415efdc9fa013502f87c27cba4a06a94c::gtnothingb {
    struct GTNOTHINGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNOTHINGB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNOTHINGB>(arg0, 9, 0x1::string::utf8(b"GTNOTHINGB"), 0x1::string::utf8(b"Glitch"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/XCAKa8vyTdynmBtR39YH7XaekplgaDiXWFv2J0hZpThFasiE3Sro4Gz7Ozdz5JNNhaXja47byTg9s5wHbguGPdiKu9Grbkb67IlEbyhVJogJMRyURotKQ0ljSK72cBoHaGZJUM8L096qJpARcenGPvJUhctuNkeQLgiOzTe1UrDiKJSHNfwitbTygRaCb-LyBn_trMYRkm30xMN0k7LtpgWqAVU05PcsMMQOQqos-8grz6Kn6o4auCGb9Rd-PElEdxnX-n9Czg1oTfk1T7Jfq_h5M5MumAZgWA-uFjPLo2ldwtcLMZoZ3LjXpWpKVRSDpPBD_xq5l-Hg4DskEzYPNQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNOTHINGB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNOTHINGB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

