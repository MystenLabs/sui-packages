module 0xbb95f095a7601a3500ee0a6983459a21ed1c91253ea2a2599eeb1e1ead76ef83::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"99fd75aad5035ecf4d88268be1f1924f1618ee6df98654bf8e3e197069a5205f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"99fd75aad5035ecf4d88268be1f1924f1618ee6df98654bf8e3e197069a5205f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TSUI>(arg0, 9, 0x1::string::utf8(b"TSUI"), 0x1::string::utf8(b"Turtlesui"), 0x1::string::utf8(b"just blast"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/911e0fe59638ea01803f20642c4b62586f71302fa77b51a1b330cefb3116fa20.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

