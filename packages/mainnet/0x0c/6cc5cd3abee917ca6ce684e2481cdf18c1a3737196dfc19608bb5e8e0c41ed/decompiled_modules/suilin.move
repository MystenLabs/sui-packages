module 0xc6cc5cd3abee917ca6ce684e2481cdf18c1a3737196dfc19608bb5e8e0c41ed::suilin {
    struct SUILIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIN>(arg0, 6, b"Suilin", b"Suiet Union", b"Welcome to the migthty Suiet Union!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/head_208ecb95e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

