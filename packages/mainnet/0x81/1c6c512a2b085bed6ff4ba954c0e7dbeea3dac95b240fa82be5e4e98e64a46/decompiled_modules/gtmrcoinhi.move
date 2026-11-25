module 0x811c6c512a2b085bed6ff4ba954c0e7dbeea3dac95b240fa82be5e4e98e64a46::gtmrcoinhi {
    struct GTMRCOINHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMRCOINHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMRCOINHI>(arg0, 9, 0x1::string::utf8(b"GTMRCOINHI"), 0x1::string::utf8(b"0xCoin HiHi"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/lgUptvahQxmZFxPQ2SElTfVIQqMf6JJqKWZ3thtzgPXeexv8kHg81M3_UYTSfMAPmxIXJysbCFiUxXWA_0pyHcLES6Hf61kw4raotLej7yZrqLbDJyuOnb1eJAxqN7Z_W3y7hzeqR18OLEOhgt4FTNpTfvlVST0vX13BxkEgzFKCDybYdw3J-6TsnFza40HmFHQvLgqXDMmJSIDcmRNVjZEvprzZuORw9eXfwDCBRSloemX-dEb2NgKWZ4iGb-BKZecXC9hliDfXH3a-yGbfkHhdaqdZwaxhmwm4Jhyp1fP5D_O08l-gG_KX9QYK0EwO1cSVLPPbQkQv3L8bzwKnKw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMRCOINHI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMRCOINHI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

