module 0xccac6c7466eae572f5c9b0e096dbf316d540e45ecf56f20881b2844b46c5df6b::claudia {
    struct CLAUDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAUDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"5062391d17da725365ef0a5de1a6eca80d1186f1482cb86798c4644cd2556af7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"5062391d17da725365ef0a5de1a6eca80d1186f1482cb86798c4644cd2556af7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CLAUDIA>(arg0, 9, 0x1::string::utf8(b"CLAUDIA"), 0x1::string::utf8(b"CLAUDIA"), 0x1::string::utf8(b"Claude x Nvidia. They need each other."), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafkreierrgayp7rbtdictugmvyqubxtyau7o546rhujrvgpznrdiiqpali"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CLAUDIA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CLAUDIA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

