module 0xf8da4d10dd1bf19ad4842b8d92c76b721b09e87330bb9f52050e6bde67a80db8::cokkie {
    struct COKKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKKIE>(arg0, 6, b"COKKIE", b"Cokkie token", b"COKKIE token on Akasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/20ca5e53-e4b3-4401-9e86-865dc5dbedef.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COKKIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKKIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

