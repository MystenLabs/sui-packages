module 0x1d1084d309f411cd5de0554a4861743d8a012cb43335b3b6c7a989c64810881f::titi {
    struct TITI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"fcf3ab4396ac3392a974a4a707f43f8b4dddba98fb4ef6dc9f76dddc24f5d140")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"fcf3ab4396ac3392a974a4a707f43f8b4dddba98fb4ef6dc9f76dddc24f5d140"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TITI>(arg0, 9, 0x1::string::utf8(b"TITI"), 0x1::string::utf8(b"Blastiti"), 0x1::string::utf8(b"hot blasty"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/01927896b22979a38cfdd8dca6f43a8dc2688711386dca3bdc1c9835a758594e.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TITI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TITI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

