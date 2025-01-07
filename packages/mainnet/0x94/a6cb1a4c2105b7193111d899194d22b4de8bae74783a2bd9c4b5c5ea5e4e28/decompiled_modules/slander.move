module 0x94a6cb1a4c2105b7193111d899194d22b4de8bae74783a2bd9c4b5c5ea5e4e28::slander {
    struct SLANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLANDER>(arg0, 6, b"SLANDER", b"SUILANDER", b"Top Model Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilander_27db0a9940.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

