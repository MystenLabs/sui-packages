module 0x351e4f4073d489a0ada11d02e22805971f454c3f1b64e808f2d1b72de9e8796::gam {
    struct GAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GAM>(arg0, 6, 0x1::string::utf8(b"GAM"), 0x1::string::utf8(b"Give me all your money"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://popularsui.xyz/media/6950a4d97e013220354dde71192b9c8ba7a6aa94deb3a6282255c06f3531a674.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GAM>>(0x2::coin_registry::finalize<GAM>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

