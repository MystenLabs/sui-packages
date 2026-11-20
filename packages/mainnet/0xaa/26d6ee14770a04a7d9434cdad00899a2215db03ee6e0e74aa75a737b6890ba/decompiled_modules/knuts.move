module 0xaa26d6ee14770a04a7d9434cdad00899a2215db03ee6e0e74aa75a737b6890ba::knuts {
    struct KNUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4ade30af851559af7ec3f1203298e0eb7dc0a1b650e4bf3bae53a7670800b9ae")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4ade30af851559af7ec3f1203298e0eb7dc0a1b650e4bf3bae53a7670800b9ae"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<KNUTS>(arg0, 9, 0x1::string::utf8(b"KNUTS"), 0x1::string::utf8(b"knuts"), 0x1::string::utf8(b"knuts on sui"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/7ed57661d32304eac4a7f62a8cf16c448c75addaac08f052eb823404cf16c3a1.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<KNUTS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<KNUTS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

