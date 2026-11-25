module 0xb1e88e8624d1cde3391d3e3c9d86295dd370ab6dff7be17511abcb9c7dcc63ee::gtdeltasc {
    struct GTDELTASC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDELTASC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDELTASC>(arg0, 9, 0x1::string::utf8(b"GTDELTASC"), 0x1::string::utf8(b"Design"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/l3TVEUMiSRY7gF4twOlEvmWP5uRfOP4oB9fSJCM2_QxgGWCZHcKdxNRZJGiBD_iSFUBSNniUuTtaKk6AoUjTFohkdbPLQtfNCrVnProJsaAR7dPRc7ye-2hvMkR2P6IWyhHK1DR0qPAXpTz0ICBYAXiK2It7J0T-pNIWOoVkxbNkN7zY-JlCrakOmFlZn4WEQqhBgUCw4DzjgzzaxCcLSimFyUgU6NXER-dqZ1GJtz2yQMJBQ8oHkJNG12P9UNlpfO1Mk11Bmk7DJmooLECsSo-wBRXXCuyh1W2B_0G1dyuv9j8UDr8CfkLKyaIO9oD2S6Erc1zNESmd30RGKrT4HQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDELTASC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDELTASC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

