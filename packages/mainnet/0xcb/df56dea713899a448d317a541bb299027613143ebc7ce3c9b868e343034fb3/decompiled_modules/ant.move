module 0xcbdf56dea713899a448d317a541bb299027613143ebc7ce3c9b868e343034fb3::ant {
    struct ANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e612ffa41149106d593942d450a1e297878d666613c29de95fd0994cd4cae0d0")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e612ffa41149106d593942d450a1e297878d666613c29de95fd0994cd4cae0d0"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ANT>(arg0, 9, 0x1::string::utf8(b"ANT"), 0x1::string::utf8(b"Ant"), 0x1::string::utf8(b"Ant"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f467b0a0bfd7da38da83357cb721ab5dc163d18f0846e24173b608aae4331c8a.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ANT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ANT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

