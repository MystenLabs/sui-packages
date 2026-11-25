module 0x76d88033af4e04027bcddf6b3fdbb954d957e216503d73d14c854a029936f8f2::gtluceeher {
    struct GTLUCEEHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLUCEEHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLUCEEHER>(arg0, 9, 0x1::string::utf8(b"GTLUCEEHER"), 0x1::string::utf8(b"Lucee"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/I7AMTz7VbsmS_xy7gDziRzUJl61CKT2GfaeEDgmE5AJbtmoAdkfCVdGCCdCjP-LmxdKMftAqVlZZQbJK0MVxhlD8eknn_3MAe75Rs5SVOR0WWmp0uu-mtiYWV1k486VVF9EsXV_T1NVkI8u0FMNrVf9XzzSN7zjRq3jrim4NqmaKsZCFC7UP3YCa1Cr_yVgvPKocp4kCGDIazBFzL8uJpen18y3OhXFlkpB4wp96hmt6U0uf29JZqmBntKRMxtvWcn7w8MUKKFaJz1zaXfNVPoMJMM16J50gpeOfXWwoeVb172mTQLvDOw5EC5gClAFiTZRz2F6mSrnc2czFhNTlDQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLUCEEHER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLUCEEHER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

