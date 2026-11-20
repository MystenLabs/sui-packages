module 0x4ae1a9c3fc8aa196c5c7915797e3ef8a0fcba5fcf276122d0133f77c4198437f::exit {
    struct EXIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"7bf7fbb19ef175a77751d74618318983a78aeb32763efa58d9a2db60016e191b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"7bf7fbb19ef175a77751d74618318983a78aeb32763efa58d9a2db60016e191b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<EXIT>(arg0, 9, 0x1::string::utf8(b"EXIT"), 0x1::string::utf8(b"Exit"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/617734952ea20d58181fb520a42aa756e83a343f99d700250f9cba5fda25db2d.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<EXIT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<EXIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

