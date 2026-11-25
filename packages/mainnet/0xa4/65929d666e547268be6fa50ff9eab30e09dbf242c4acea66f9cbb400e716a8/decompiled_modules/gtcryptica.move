module 0xa465929d666e547268be6fa50ff9eab30e09dbf242c4acea66f9cbb400e716a8::gtcryptica {
    struct GTCRYPTICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCRYPTICA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCRYPTICA>(arg0, 9, 0x1::string::utf8(b"GTCRYPTICA"), 0x1::string::utf8(b"0xnaut"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/jSa5s69HePeeIvhNnJM-hnsSdWEInBwFOxkCSuwAM58uzd2MnP7gzlxbHhw8qN6G0MQK1xRmz94wZ0y9sx6pY8WbTGq1gXYncpHI7sCHiPdRI9__JQRr6gXar-b1DvEO90RpFur0ZhzOtAdCRGLnYVERVcwlABOvY4vi2T36-lj10oxqgY1-nntS6HIMvtIzeWUkAgAl9PR-B530vQC4E71jCg4KBh6USweqGVe7qwRF0eYji7QWMrhclkcN70puiBZjlH1v-EWqEV1fRP5GtvaTFemB1wpNl0gqPGuKuhjIrpY5Jk638R9J7c9ao3hye6PfmAFbmXsV2sqaJ4IhEg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCRYPTICA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCRYPTICA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

