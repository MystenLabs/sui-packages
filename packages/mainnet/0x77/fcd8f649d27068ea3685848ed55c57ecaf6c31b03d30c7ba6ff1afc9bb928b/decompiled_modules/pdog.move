module 0x77fcd8f649d27068ea3685848ed55c57ecaf6c31b03d30c7ba6ff1afc9bb928b::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 6, b"Pdog", b"PoochDog ", b"Just a dog named Pooch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731966264379.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

