module 0xe88dba8c98a856b7dc118b153b2f02e54050e8c3dfe438f15fc7d9030af28a9e::brai {
    struct BRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"d4b842e695f51dbdb67c3e4dc126c1ca0ba5fca65bf1b692cbe7ef7579b70dc1")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"d4b842e695f51dbdb67c3e4dc126c1ca0ba5fca65bf1b692cbe7ef7579b70dc1"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BRAI>(arg0, 9, 0x1::string::utf8(b"BRAI"), 0x1::string::utf8(b"Braindance AI"), 0x1::string::utf8(b"The next generation of AI is supported differently. While everyone is chasing GPUs and AI infrastructure, the internet has discovered a new kind of support for the AI revolution. This is a joke-driven community token, not an NVIDIA-affiliated project."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f9d149316ff491d991c50e6d5e6ab022266a787abe76ce64ab17140de0779f77.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BRAI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BRAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

