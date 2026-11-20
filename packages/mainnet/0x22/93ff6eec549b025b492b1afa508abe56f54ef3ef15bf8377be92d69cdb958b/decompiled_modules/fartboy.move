module 0x2293ff6eec549b025b492b1afa508abe56f54ef3ef15bf8377be92d69cdb958b::fartboy {
    struct FARTBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4475bb7552694d3e7a12f8ff5308a00c939b2d5a90d276cb78cb72bbef723ace")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4475bb7552694d3e7a12f8ff5308a00c939b2d5a90d276cb78cb72bbef723ace"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FARTBOY>(arg0, 9, 0x1::string::utf8(b"FARTBOY"), 0x1::string::utf8(b"FARTBOY"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/da431a5c26e96cd74ef9ad5162cfc5bcf0c8e013a5204347e9bcfee99171e040.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FARTBOY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FARTBOY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

