module 0xce5081712f54927f113916bb93960f15276503e619c8cac1df6aa09509da729b::one_coin {
    struct ONE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE_COIN>(arg0, 9, b"ONE", b"one coin", b"just one coin here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8dc08a81-12b2-4c77-bea3-0bf6edf8ec07.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

