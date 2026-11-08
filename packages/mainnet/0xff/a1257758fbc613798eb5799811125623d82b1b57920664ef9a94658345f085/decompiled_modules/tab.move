module 0xffa1257758fbc613798eb5799811125623d82b1b57920664ef9a94658345f085::tab {
    struct TAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a210093f542e8c7f1fbec01604d652d3bb801cf154436ed46d26a5b2b658a0f5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a210093f542e8c7f1fbec01604d652d3bb801cf154436ed46d26a5b2b658a0f5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TAB>(arg0, 9, 0x1::string::utf8(b"TAB"), 0x1::string::utf8(b"One More Tab"), 0x1::string::utf8(b"Just one more tab before the next big thing."), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TAB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TAB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

