module 0xe40a322fa0280ec8ec1b98daaff0fc7ea0a9cffdb68ab05a0e620d2fa25ac018::byegary {
    struct BYEGARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYEGARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYEGARY>(arg0, 6, b"BYEGARY", b"CYA GARY GENSLER", b"GOODBYE TO GARY GENSLER!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_06_at_12_34_16_3f2895c2e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYEGARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYEGARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

