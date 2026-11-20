module 0x28e833ba81211fc737965b3b80e808b1483e1cd5b11df474f0bc3e5172df6af9::hawaii {
    struct HAWAII has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWAII, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3de509460033261ff3044352383f4a5b2235ff07d90a706ba3458e6c1f92f706")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3de509460033261ff3044352383f4a5b2235ff07d90a706ba3458e6c1f92f706"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HAWAII>(arg0, 9, 0x1::string::utf8(b"HAWAII"), 0x1::string::utf8(b"hawaii"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/41d12d2353eb04e712768a78015fb0ff0b483bb6269f50c4836472580cbde9f9.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HAWAII>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HAWAII>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

