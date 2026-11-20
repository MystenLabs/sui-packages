module 0xbe9e4f27503d48b167f76fd0cfeeb6a549f50976287e08098b9f66e7924d9d2f::blasti {
    struct BLASTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a0a0fa961552e971f89a745fddc4c386639ce4d8ab546d8ba74eb0ffc1b5eea3")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a0a0fa961552e971f89a745fddc4c386639ce4d8ab546d8ba74eb0ffc1b5eea3"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLASTI>(arg0, 9, 0x1::string::utf8(b"BLASTI"), 0x1::string::utf8(b"blasti"), 0x1::string::utf8(b"blasti"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/6ee7eebd4579ca6f1efb2438f7cb3d13383d3005c92a4e9cd10b4a8ade913f39.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLASTI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLASTI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

