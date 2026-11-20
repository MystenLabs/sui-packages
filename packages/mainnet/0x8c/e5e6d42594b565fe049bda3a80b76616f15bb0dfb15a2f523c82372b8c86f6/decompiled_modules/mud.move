module 0x8ce5e6d42594b565fe049bda3a80b76616f15bb0dfb15a2f523c82372b8c86f6::mud {
    struct MUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f455e34d8e86cf71d5fe7056ac7de78f879dd834e27dd334ac15f3c7cd805a7f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f455e34d8e86cf71d5fe7056ac7de78f879dd834e27dd334ac15f3c7cd805a7f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MUD>(arg0, 9, 0x1::string::utf8(b"MUD"), 0x1::string::utf8(b"Mudlark"), 0x1::string::utf8(b"The house coin of Mudlark, the launchpad for digging up coins on Elysium."), 0x1::string::utf8(b"https://mudlark.fun/social/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MUD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MUD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

