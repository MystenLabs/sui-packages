module 0x7455953898c50081b22a68bdcf9fa72dc99e947e0fb02f44bdd025043317d853::hmm {
    struct HMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"507be0ca492032aa0044435819fc36fe6429347bbf24794af2e8b9674f1553f9")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"507be0ca492032aa0044435819fc36fe6429347bbf24794af2e8b9674f1553f9"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HMM>(arg0, 9, 0x1::string::utf8(b"HMM"), 0x1::string::utf8(b"HMM"), 0x1::string::utf8(b"thinking cat on sui"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/5f0b65ab2cbd90f2333f1d7e5f8e747ce7a202877b62979b070b65a6d0413def.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HMM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HMM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

