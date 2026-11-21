module 0xefa141cdb751f74fa95e6aa60a9843166bb32b42e11be66d181c8fb765e2f517::gta6 {
    struct GTA6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTA6, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3014947db973c5fed397a779bac4f4897cde85c88a465b142a6accf9fd6cab3d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3014947db973c5fed397a779bac4f4897cde85c88a465b142a6accf9fd6cab3d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTA6>(arg0, 9, 0x1::string::utf8(b"GTA6"), 0x1::string::utf8(b"GTA6"), 0x1::string::utf8(b"Lets start GTA6"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/9e81bd04999f63f4eb57a063414ab89e2a166be23944e00732980abfc07fad0f.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTA6>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTA6>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

