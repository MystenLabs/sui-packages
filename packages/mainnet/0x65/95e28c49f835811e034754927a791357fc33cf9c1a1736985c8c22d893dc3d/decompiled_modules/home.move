module 0x6595e28c49f835811e034754927a791357fc33cf9c1a1736985c8c22d893dc3d::home {
    struct HOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOME>(arg0, 6, b"HOME", b"Homele$$", b"Rugged to homelessness and now resorting to sucking *ick on the street for more rug money.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ojibwa_85718_homeless_man_with_shopping_cart_d2c200b1_7fe7_4074_959c_5fe87181929e_dd2eed8741.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

