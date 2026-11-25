module 0x72840386d45e7e4ea9846782c4296309e7e20b122bfb68d78e2a225ad855245f::shou {
    struct SHOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"0af83ce7e5991fa54c976a979b316b3ea823b4fe040ebcca2fa63af200085594")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"0af83ce7e5991fa54c976a979b316b3ea823b4fe040ebcca2fa63af200085594"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SHOU>(arg0, 9, 0x1::string::utf8(b"SHOU"), 0x1::string::utf8(b"shou"), 0x1::string::utf8(b"yasss"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/cf60f3296be60e24afb185008233b6d87fc976cbc8825fd1505a929b4cc566af.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SHOU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SHOU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

