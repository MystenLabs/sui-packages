module 0x845c74eaddcc31e060eb58d8825a785acf1f09a5c4e490462ce2c1a2c4137e5f::gtsigmacit {
    struct GTSIGMACIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSIGMACIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSIGMACIT>(arg0, 9, 0x1::string::utf8(b"GTSIGMACIT"), 0x1::string::utf8(b"Sigma City"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/TgmTLzHselhVSr_BIzQvPCp7ybrCjpZDgVATeEAHnwpW20QpoxZUvZvpp6Trj7ul6WNsSCYRPWvx_nBTFWCX6bV1DH-F1ZloDhzMnVaPEd5BgbQn9VV_ttkZm178IaO6mxMsatmi89rnJ_47F0FjCKtl-b1lQ7jkLbKVzTABLHiXLfhG4dli2CCCFfeqDZr5O1-58ZAcqrQRtiwJvf3nGKcIJWLF43DbArOiTi2Iy-gInqZCiRKcAvn7zg3HnN1J6u3ieEzX3BcYmy2uwqsXnnJoQw72CnJWVAJ0CitPAuERk-qHH8013QYoYgnvGsQHu0aeD7PqmHeyQPqYRpVyWQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSIGMACIT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSIGMACIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

