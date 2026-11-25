module 0x3ae3a936fad56942224f74c7f2a5e705635fe91cfc498f290a87115d6ca3d1ea::gtaixd {
    struct GTAIXD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAIXD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAIXD>(arg0, 9, 0x1::string::utf8(b"GTAIXD"), 0x1::string::utf8(b"BlastOff Mod"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/OExonWkR4jXsh-KdIPvCahzLHcLM8wU6VOqg32Vb4SWI47wmDUDPK_jmD73yFKAHCoSsR7HprRAA6sEEplu0h_WkJv1EluGoTJD5_bTSX2KAQr6BFTJmXKL6C-R5ZENYbLTfG8mo0ZxQIK8BpGD-BqweQGWH-QA9ZXddNeDHx-ckErNiZRH5LWj6iW4zPkuVkmPgytI7ZNFEW_GcQDrbrZPaBMEJDbpfr3zN3w6vKu5si3Nyf8k4mzZ4GLEOoJbfJXtXw6_6df1Mc4oaAaapi4rLqMG9Oq_w8WDed0jKF7sYagKSWxgDSf6kZrtdUZTAu4ZTQLATwhmer7l-31fPpQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAIXD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAIXD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

