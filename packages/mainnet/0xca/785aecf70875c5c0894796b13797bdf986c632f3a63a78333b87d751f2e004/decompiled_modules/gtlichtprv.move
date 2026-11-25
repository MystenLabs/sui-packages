module 0xca785aecf70875c5c0894796b13797bdf986c632f3a63a78333b87d751f2e004::gtlichtprv {
    struct GTLICHTPRV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLICHTPRV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLICHTPRV>(arg0, 9, 0x1::string::utf8(b"GTLICHTPRV"), 0x1::string::utf8(b"Licht"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/kXYpKqJ_qhNf9RS42x7fRmCxJw-vEiBB0UCHznDXYX9qbCGu4_hYnKQ3CXXDH64gxlKPjZGBNobMUKQhQVitPSPr_BU5BgVTfcjgt3CItVJXAt0uqtO0QSBX4aCqcJXNIzuNo_kFgUIfowmTOI1GiX5MVzuiaxrsKrEjBAIQCMdlSo3sx1pzj0AMom9CKzY_yNShhJosEcxFpMri9z7swL1c7L1GBU3XQWJbZJ5AohzfE0ymSPXLp5nC3j9KZ21Ih4nU1wQFC0dgNf754NZd40BN3HJqS2C2_8kM5hAeErI2nLKt3gcx0eUcrVzLYpp1U-eMEsgwfSKgh_AcrXGHSw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLICHTPRV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLICHTPRV>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

