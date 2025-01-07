module 0x64d1cebad5d9c8270ad5520bcd36b438e39be3da6a104d21820f17f78253db38::jnix {
    struct JNIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNIX>(arg0, 6, b"JNIX", b"Jnix - League Of Legends", b"Jnix - ADC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a1234_daf7e887ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JNIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

