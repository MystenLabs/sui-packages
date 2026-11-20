module 0x63b6379400d749dbe9b200c980247d89d797b9c44b5214543e0790cada1f1c9f::muster {
    struct MUSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"b3bd35bb2a155de52862f0d6f24770bebaec2bbb7bd1c4bb928e2710b73fa069")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"b3bd35bb2a155de52862f0d6f24770bebaec2bbb7bd1c4bb928e2710b73fa069"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MUSTER>(arg0, 9, 0x1::string::utf8(b"MUSTER"), 0x1::string::utf8(b"Muster"), 0x1::string::utf8(b"The Muster platform coin. Pledge-to-launch on Solana."), 0x1::string::utf8(b"https://musterup.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MUSTER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MUSTER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

