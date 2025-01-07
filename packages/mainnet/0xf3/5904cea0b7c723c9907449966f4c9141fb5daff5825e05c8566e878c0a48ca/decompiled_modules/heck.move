module 0xf35904cea0b7c723c9907449966f4c9141fb5daff5825e05c8566e878c0a48ca::heck {
    struct HECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HECK>(arg0, 6, b"HECK", b"Heckin Test Project", b"Broter, you dont even wanna know", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731279352379.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HECK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HECK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

