module 0x4da5cad6753d2b97c5b37e718ea481abd9b551c657994e5045849797a502ce4c::gttactical {
    struct GTTACTICAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTACTICAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTACTICAL>(arg0, 9, 0x1::string::utf8(b"GTTACTICAL"), 0x1::string::utf8(x"e6b1a4e5a78620544f4d5a204953594f5552474f44"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/bb9uEZ1iss6DbiKlECYWNVeKsg2Vz-Q_Ytu6h3KUCG9vCtFHbpK51B6hd_54aAdqPIlhUv6boI1APkPlfIi_Hf-LBg3qL1dI2U40lvT-rodA2IyjOgOkhKZqzEjglP87YZjHAZBDV_7z0YvBjKYld9W5w71UeIlTB5WFyquiJ9nL-k-u5GiSAZoRMKD37TGCI8O8NzHLBQ9-ijgRZMXUcWA5M7A0Yi6CoddPBLDyKDRGdvSSpgQN1yHzBNxTODIA4y_GRx9sHFYFJxWebUK5YBjDF41aiAxfqdPOGdp7P8g7LHkUfC3D4KXjzFJY5dZxSr4-Vk8AsgtYJOaQBtif7A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTACTICAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTACTICAL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

