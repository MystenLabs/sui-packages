module 0xfe7edf6fcac2df0e5e7fd00e6ffd167a13d38bb4ee3eb4c4a14e8106d1891903::gtbloxsui {
    struct GTBLOXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBLOXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBLOXSUI>(arg0, 9, 0x1::string::utf8(b"GTBLOXSUI"), 0x1::string::utf8(b"Bloxsui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/LUO-m-gCo6TDQEkQ3uG91KP8yURcsK00v5S6emak4LlxD_gzKI82IsYgaTIAgVKVSZU5UgAtffGFC35w-VpIKgiC2RnP8S_2MV4k9IUDGuF4cziW3HswU8aCtr7r6e8DqI8Y8rnuSJVXYGLK6uicVsRGvqBGXD2qWYjspZMrRL-K-lICmUbpvtRFLUgzxPznuu8CFeh208IQ4W2Z1FUKswRxBEb2elu911jW6SqgbOgFX8ZA2q_vc6V2AJhTX_V2Y9qEcDIm6J6o06A3SiBkSo8lU9OpDfkRFHQuTyRpLnwluv_RDJoCC3-hshkoGKgAnPWqN6jJYAbzFci8XkS46Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBLOXSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBLOXSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

