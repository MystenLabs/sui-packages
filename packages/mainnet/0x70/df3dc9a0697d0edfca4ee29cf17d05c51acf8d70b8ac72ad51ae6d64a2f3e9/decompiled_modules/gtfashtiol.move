module 0x70df3dc9a0697d0edfca4ee29cf17d05c51acf8d70b8ac72ad51ae6d64a2f3e9::gtfashtiol {
    struct GTFASHTIOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFASHTIOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFASHTIOL>(arg0, 9, 0x1::string::utf8(b"GTFASHTIOL"), 0x1::string::utf8(b"Fash"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/hxd07TJ24ckLUhgnLcTwsMUTFADvVx9lsmpJoA2vbKIHDBsFq4EzpOuo5QJPaQCuOijlp_K43ICpajvdzFP09r-Yd_5efN1QA8ZJSDl8Vu84AxXmLtZnA7T5PGwdQy3_kSc8S2dizHzqUShtiKpL9z5sZZJwawHSbAgxjoK1UPMTiLvi5VdIbpZ8OQktqN1sqQj0mnLaGLVTENWvkXwjCdsXwMl3otz2cUdMORqP7SdXsRDg_0UyDav3ep3Cl-dRVL31CFnUCWEVD8FBNOzN76gKEXavKDXUYmCt0gQCy0-34BiSiqszCyWojNLy6d9qu8d3epQZXY3eJJQZ2bglgg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFASHTIOL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFASHTIOL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

