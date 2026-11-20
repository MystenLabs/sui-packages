module 0xecad508511149f3efe0c49a5b7d3148a24d490c285a4ace75094380301755828::tarn {
    struct TARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"6cd72312459fa5da92acbe8b351a4a904ac89793bddc83846ad4079e67fa6673")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"6cd72312459fa5da92acbe8b351a4a904ac89793bddc83846ad4079e67fa6673"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TARN>(arg0, 9, 0x1::string::utf8(b"TARN"), 0x1::string::utf8(b"Tarn"), 0x1::string::utf8(b"Presales at the edge of the lake. tarnsakr.xyz"), 0x1::string::utf8(b"https://tarnsakr.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TARN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TARN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

