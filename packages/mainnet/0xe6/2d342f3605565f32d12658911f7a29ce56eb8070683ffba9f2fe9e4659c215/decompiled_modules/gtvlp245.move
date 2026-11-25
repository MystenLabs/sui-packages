module 0xe62d342f3605565f32d12658911f7a29ce56eb8070683ffba9f2fe9e4659c215::gtvlp245 {
    struct GTVLP245 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVLP245, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVLP245>(arg0, 9, 0x1::string::utf8(b"GTVLP245"), 0x1::string::utf8(b"VLP"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/idm00r754ZDTFAuBCcVPOFfOOehu4ZiLXIhUagxPfdctJTq6Mc9fzxQexrOn-0fW1FZdet40MxTL4F5KSLwoNhA4aE6z7KznrFhGDPYOJHbGG2woNUBbLLJ6OG_9hiTSAS--ffffC00MqhivBIaj-bAJNZvh9sxy-Lf5yPqeIlmVVczppEFrjVUnD6Lwsci5fxA94P_ia-zol43EzhyoxFOUXEMi01MuwZnTt3vP9BgK2UYvQwSIhVeteVk3BIYdU3TcoExYf6ph0NFRaq4xtNGfl9RcE8Ir1Dv9jom5uGVGC_qhYd31cdK262LDViF0XS5gLxplhBMeL73pANvSTQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVLP245>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVLP245>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

