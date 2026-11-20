module 0x768f8880e21b7ba7b04c67d3de7f3e1cc68861328b3951ebdfe5c95a19cbba2f::bgbcat {
    struct BGBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a67577eba21748f60e2f813ac0755135e1231280525679364025e19e9f77f28b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a67577eba21748f60e2f813ac0755135e1231280525679364025e19e9f77f28b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BGBCAT>(arg0, 9, 0x1::string::utf8(b"BGBCAT"), 0x1::string::utf8(b"BGB Cat"), 0x1::string::utf8(b"Cat inspired by BGB from bitget This time it's Sui"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/62a2e3bc52690e18f7cee2d43d275c8c6a349fd4ee94ff8bc5c1251473da462d.webp"), v0, true, 100, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BGBCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BGBCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

