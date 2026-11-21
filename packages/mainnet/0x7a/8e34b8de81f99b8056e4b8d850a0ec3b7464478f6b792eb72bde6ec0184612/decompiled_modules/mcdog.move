module 0x7a8e34b8de81f99b8056e4b8d850a0ec3b7464478f6b792eb72bde6ec0184612::mcdog {
    struct MCDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"33ce4b8c946454ac96afa3a2e11d088c7203e421b10c76cafd86e54436f9fb51")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"33ce4b8c946454ac96afa3a2e11d088c7203e421b10c76cafd86e54436f9fb51"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MCDOG>(arg0, 9, 0x1::string::utf8(b"MCDOG"), 0x1::string::utf8(b"McDonald's Dog"), 0x1::string::utf8(b"McDonald's Dog"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e2ecf642a1d4ca8220825d7661fd9f2d0ca8492a027dd2cf52d7a732df501387.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MCDOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MCDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

