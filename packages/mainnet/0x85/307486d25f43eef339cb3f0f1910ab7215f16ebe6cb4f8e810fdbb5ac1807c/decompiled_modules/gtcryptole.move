module 0x85307486d25f43eef339cb3f0f1910ab7215f16ebe6cb4f8e810fdbb5ac1807c::gtcryptole {
    struct GTCRYPTOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCRYPTOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCRYPTOLE>(arg0, 9, 0x1::string::utf8(b"GTCRYPTOLE"), 0x1::string::utf8(b"Magic Leper 069"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/qpMR9Fwabe3iYQ0__d-wPyw_RE6GYOMGQx5i4Mu1yiE0kn-tyRc8czn46YRKxmrOlrO-ZWsftpRhGXVffy2PiWfk56PKjkL4i_ixnBhlgNWNjPfXS6Q5vdnfRCIp4ChKnjsWjM5iH2taCRUZ9Gl5e1NHtdgnK3U4pCjfKFV6jZVaOXMOCoRBzxYAjn9TGusnfGYYQ2EhyXM2nXz7nPZbc0ip1jR2iBKS6CTUwr3tgDI-kBilZCcNPqn5p2TPLLx9P7cbRECtzjuuEtHH_UHGiMIJOWlIUaeFtxPR2gwqTJnO_1eTSHmgE9eM717cMxTVsjUIjHeiarle53YjKRMaRA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCRYPTOLE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCRYPTOLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

