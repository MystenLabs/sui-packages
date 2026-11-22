module 0x9d2c1dcd353aa766982b6311ff99678e8b5d3645be6b6a7b08caed510eaa92ac::kares {
    struct KARES has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"0ec50de4c7fbf5b8ac34df44da8fba339af02f6c83ba82cefd786065644d89a3")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"0ec50de4c7fbf5b8ac34df44da8fba339af02f6c83ba82cefd786065644d89a3"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<KARES>(arg0, 9, 0x1::string::utf8(b"KARES"), 0x1::string::utf8(b"KARES"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/9561bdc1228640d6d36b9149418d4bd16db78855212db2b5e818416c9c4e94f2.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<KARES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<KARES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

