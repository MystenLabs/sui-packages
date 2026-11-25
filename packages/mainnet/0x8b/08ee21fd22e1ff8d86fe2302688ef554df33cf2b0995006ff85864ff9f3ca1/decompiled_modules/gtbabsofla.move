module 0x8b08ee21fd22e1ff8d86fe2302688ef554df33cf2b0995006ff85864ff9f3ca1::gtbabsofla {
    struct GTBABSOFLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBABSOFLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBABSOFLA>(arg0, 9, 0x1::string::utf8(b"GTBABSOFLA"), 0x1::string::utf8(b"Silk"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/jfvzplXmUnXMps1HaXpZaV2hlf2l1kLy1JMlOuq0LYIA-WgrimOCAIuICcQ2NUXBfg0PBBWXJig_6K3EoOOj-gVwjAuEoJtfEA8aW9e5XuW8KJ3CXzdJ2pibUg4aax9iuBY2s-LUEX-KshGcG0gGy2BMXBa2cq7-I401hlze81ARSyDmm-efPb3kCn5gCOk5hIifqcrMjwS3tAWBziJug7aaqlM_JKZQVpXrI6wsG9bee5vPReWO_v9zftqX0wltNAsMhNBR5Le1eQyXUHsUhFgx7-tOtBtSWVCZT8gjEk0nSf_AZ4RLOZ18_pr1Ou_BXSyik06_aGPA8x41LD6I0w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBABSOFLA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBABSOFLA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

