module 0x586c26a3bca37032344fec7bc29a157276abf16d2aac88d3b8e50da3fa56f082::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"015080c3e523e399a4f57becdb6c1dd7620472881606104ef1cbfb8038b9f71d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"015080c3e523e399a4f57becdb6c1dd7620472881606104ef1cbfb8038b9f71d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FIONA>(arg0, 9, 0x1::string::utf8(b"FIONA"), 0x1::string::utf8(b"HIPPO"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://d2ol7oe51mr4n9.cloudfront.net/user_3KSVpBFs6FNE6Kl3p4mU3cJ7PTE/9a422cf1-9a9c-4249-801f-5b67a4fb509e.png"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FIONA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FIONA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

