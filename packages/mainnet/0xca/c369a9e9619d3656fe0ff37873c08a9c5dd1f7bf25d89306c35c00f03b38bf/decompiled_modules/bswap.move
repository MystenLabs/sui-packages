module 0xcac369a9e9619d3656fe0ff37873c08a9c5dd1f7bf25d89306c35c00f03b38bf::bswap {
    struct BSWAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ad68db69cff68ad085d94d1b98050b8c5acfaf253fde680ef3f5e239f46737fc")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ad68db69cff68ad085d94d1b98050b8c5acfaf253fde680ef3f5e239f46737fc"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BSWAP>(arg0, 9, 0x1::string::utf8(b"BSWAP"), 0x1::string::utf8(b"BlueSwap"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/c85efbadaeca1391d4e01997f3d393a7d03a14f25ba6256bf48451fb69a6f536.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BSWAP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BSWAP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

