module 0xd2a36b6444d2bc2ac4a5b1135da1bd8ed3d5fc180efadfc4e98a613e396d1823::ddd {
    struct DDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"af0214be8f16254014de23aa6a94f19ff06bab1b0dac5d79faf45de601198557")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"af0214be8f16254014de23aa6a94f19ff06bab1b0dac5d79faf45de601198557"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<DDD>(arg0, 9, 0x1::string::utf8(b"DDD"), 0x1::string::utf8(b"Daddy of blast"), 0x1::string::utf8(b"Your favorite Daddy just landed on Blast."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a70b37b0c59a28378e81f318daa89bbd944823305bde42cf348718c81aef9eda.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<DDD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DDD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

