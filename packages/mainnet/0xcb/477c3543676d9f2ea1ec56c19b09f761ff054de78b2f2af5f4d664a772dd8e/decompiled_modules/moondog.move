module 0xcb477c3543676d9f2ea1ec56c19b09f761ff054de78b2f2af5f4d664a772dd8e::moondog {
    struct MOONDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDOG>(arg0, 6, b"MOONDOG", b"MoonDog on Sui", b"Moondog is a big dog with a small dream.Growing up hunting in the vast expanse of the Siberian wilderness, Moondog spent many sleepless nights staring up at the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_gif_631a67263f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

