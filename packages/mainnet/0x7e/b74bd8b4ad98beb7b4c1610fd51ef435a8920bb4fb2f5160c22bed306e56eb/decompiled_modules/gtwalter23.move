module 0x7eb74bd8b4ad98beb7b4c1610fd51ef435a8920bb4fb2f5160c22bed306e56eb::gtwalter23 {
    struct GTWALTER23 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWALTER23, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWALTER23>(arg0, 9, 0x1::string::utf8(b"GTWALTER23"), 0x1::string::utf8(b"Walter"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/JJnGPCQxEZz1_PWLT5gLZD0tod9p6tmCZ3teTbtINoIgqWKQeKFCQYTMAbrt7tYBZRPJCtku5f0Pib7KG0d2qdRrJAKVqRjh-8x1xLX6ubFgVMi0gUT2Zabox9qpK-loVgt4dFoWhlv4eSAYpjBkUEd3_1eN8e2ejcOGGLaexEu7OOhTFCKh3n5F5ZluTo31tz5zfw9ctHT7ZF47zzIh-WVCrbRoSsAvQr66w82yGlji5ZlKGkvqzGqk90UazcrJxm2bCO-ofR3u0Wd3ZjkV0Z57Tuotp174TSjIEy2AM9kRgXBbhkdQi4hlPIVP4b8oVPZK87Mt7O-34mKrKq-GZg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWALTER23>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWALTER23>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

