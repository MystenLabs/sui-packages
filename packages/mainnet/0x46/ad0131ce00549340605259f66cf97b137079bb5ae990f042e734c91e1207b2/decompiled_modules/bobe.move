module 0x46ad0131ce00549340605259f66cf97b137079bb5ae990f042e734c91e1207b2::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"Bobe Sui", b"Bobe is a very spoiled little dog and in wholehearted care, we will take care of it together. Let's send it to space ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984275725.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

