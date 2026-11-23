module 0x34e3da0a04c6581827cc22381dab6bbcd5a2dc1753e5f13108607e808248d08b::catmeow {
    struct CATMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"d618b2d2852355d163a0ba7221ab518f3136336fa33d3bc2813713afb9e33a21")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"d618b2d2852355d163a0ba7221ab518f3136336fa33d3bc2813713afb9e33a21"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CATMEOW>(arg0, 9, 0x1::string::utf8(b"CATMEOW"), 0x1::string::utf8(b"MEOW"), 0x1::string::utf8(b"Cat sui token"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/cf3422b5f600c258fff0f84d6e7462dc042ae942eda179a87728156c519a8d40.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CATMEOW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CATMEOW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

