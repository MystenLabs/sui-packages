module 0xe1352ed64ee1fcd6a2550ef264f9a8e45fed4b3e9f4a1c21ded0673a655718ea::gtatomoscr {
    struct GTATOMOSCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTATOMOSCR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTATOMOSCR>(arg0, 9, 0x1::string::utf8(b"GTATOMOSCR"), 0x1::string::utf8(b"Atomos"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/fInTHkj6WGZV8k-WMFbDc4z6biQjTVv2kN1FOdeIhtOj1da_5YSo-p1yLG18OhnxVCE_8OSC3Ou930o_E4omUjuXdu57jMmGqqCHysiOJrUJSeELLzGtV64nEcEm---gE2XEcRkHNX6qbmRXeWRAj8uwu0vvOpDW6aBHsXpvT1FI1pz99CNoh-JOQt6KLjE0YaBOadNTrdM4N4zMuWErnZSAa0NvI8Vg6HJ6H7jvCDD3ZrQS2Q0DaHLdYSczOK1tdzmljwcHe0ck33yT33_N0NFV_OzDd74qUxvaQgeaOs_L6nvE_cIA0cwK86u5WuswCshROO1LPXqVZeFRkNEXbw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTATOMOSCR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTATOMOSCR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

