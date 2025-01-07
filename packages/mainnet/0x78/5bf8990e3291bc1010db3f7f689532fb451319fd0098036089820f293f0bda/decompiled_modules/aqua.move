module 0x785bf8990e3291bc1010db3f7f689532fb451319fd0098036089820f293f0bda::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"aqua", b"Aqua is a playful and creative concept that draws inspiration from the popular anime series \"KonoSuba: God's Blessing on This Wonderful World!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731015636073.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

