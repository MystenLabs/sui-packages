module 0x45340be99e066a4de08dd7cc77f2a370decf2a3c20c12f48d1b2b52fd8d021c6::gtcckthewe {
    struct GTCCKTHEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCCKTHEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCCKTHEWE>(arg0, 9, 0x1::string::utf8(b"GTCCKTHEWE"), 0x1::string::utf8(b"CCK(Website Man)"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/ebz00SPCQJ_0g7AQnsgcPCjYLGdqG0LMfpWW6bAq4guYMUtx2AInTtG2PYZxVYymK8nYzL0Rt6XhKQBBkZrwVvGn_ibc8EJJE5aa92boKNmLzCgV9GbD6yIaRo77bTiZ9pBzK8pDl61e8PEqZN5BRaNeKqMaIkWuR6oSS6t7kWvrGTnA-Co7O3YP1U9sxDC5pgbQ1WaWb__wk38lRVBgGoFS-pe6PuBcA2PW3-3rb20ZngirZ4fPPn9DOBsR9nMItWd78pk1wWdwsqVWb0CX4lpSF4eOJ-FqEKV90QCAyPpSjuc_YoxRD1eZM4nxdvOZ2xyecoKRpW-jV3oz624gjg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCCKTHEWE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCCKTHEWE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

