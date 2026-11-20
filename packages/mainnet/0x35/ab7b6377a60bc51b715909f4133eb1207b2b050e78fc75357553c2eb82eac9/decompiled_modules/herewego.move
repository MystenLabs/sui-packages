module 0x35ab7b6377a60bc51b715909f4133eb1207b2b050e78fc75357553c2eb82eac9::herewego {
    struct HEREWEGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEREWEGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"44992bbcb331bf0d21610b632505cb744e1e8177b04c54eaa9edb0730fb94276")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"44992bbcb331bf0d21610b632505cb744e1e8177b04c54eaa9edb0730fb94276"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HEREWEGO>(arg0, 9, 0x1::string::utf8(b"HEREWEGO"), 0x1::string::utf8(b"AH SHITH HERE WE GO AGAIN!"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/2d92309784236cb86c94cca28e9a8199af2b68630147ce6ec88f3e098b4969d8.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HEREWEGO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HEREWEGO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

