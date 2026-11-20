module 0x1de8a023df84a97eb0d0dd4fe8665d6a9b4223613d9ecb6e5e0e67637cd4170f::spiderman {
    struct SPIDERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIDERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"3de509460033261ff3044352383f4a5b2235ff07d90a706ba3458e6c1f92f706")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"3de509460033261ff3044352383f4a5b2235ff07d90a706ba3458e6c1f92f706"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SPIDERMAN>(arg0, 9, 0x1::string::utf8(b"SPIDERMAN"), 0x1::string::utf8(b"spider man"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/c053c9d1a1fe41b75d536427d08430f5e04b0f0e28c569f3f56498d7a35c6d70.webp"), v0, true, 4400, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SPIDERMAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SPIDERMAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

