module 0xe451a4002e16c8bf3d80eb88b884924006804d142105f8b43dc143b6878af1a8::scallper {
    struct SCALLPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLPER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"21e05605c6f19f09bf282986aa68f6b544b1ab187feff522e7c455d8aa084bbb")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"21e05605c6f19f09bf282986aa68f6b544b1ab187feff522e7c455d8aa084bbb"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SCALLPER>(arg0, 9, 0x1::string::utf8(b"SCALLPER"), 0x1::string::utf8(b"scallper"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/ca7501fca00c998519b291df78d77460abe7c6fd42856292a4584d3279f4f991.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SCALLPER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SCALLPER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

