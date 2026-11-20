module 0xba2080d1d29268f79a2ecf66f8790d55ca962bae6566b9b6ab7d077d4937eb7e::js8 {
    struct JS8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JS8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"21e05605c6f19f09bf282986aa68f6b544b1ab187feff522e7c455d8aa084bbb")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"21e05605c6f19f09bf282986aa68f6b544b1ab187feff522e7c455d8aa084bbb"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<JS8>(arg0, 9, 0x1::string::utf8(b"JS8"), 0x1::string::utf8(b"joy suitation 8"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a08d860b0adb3a77c66e85ab711fe3db02d54d6a5f6235c2ff49aa9ba10015a4.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<JS8>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<JS8>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

