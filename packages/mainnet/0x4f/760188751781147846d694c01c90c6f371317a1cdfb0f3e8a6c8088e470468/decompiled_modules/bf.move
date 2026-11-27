module 0x4f760188751781147846d694c01c90c6f371317a1cdfb0f3e8a6c8088e470468::bf {
    struct BF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"99fd75aad5035ecf4d88268be1f1924f1618ee6df98654bf8e3e197069a5205f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"99fd75aad5035ecf4d88268be1f1924f1618ee6df98654bf8e3e197069a5205f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BF>(arg0, 9, 0x1::string::utf8(b"BF"), 0x1::string::utf8(b"BlackFriday"), 0x1::string::utf8(b"Blackfriday on blast"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/47b5e207df1acad0e4330db23ad15518c4ad76da6f8bb44e58d34b910ad53459.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

