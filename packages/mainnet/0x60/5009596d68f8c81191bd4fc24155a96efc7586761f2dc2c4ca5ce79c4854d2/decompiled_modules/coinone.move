module 0x605009596d68f8c81191bd4fc24155a96efc7586761f2dc2c4ca5ce79c4854d2::coinone {
    struct COINONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINONE>(arg0, 9, b"c1", b"coinone", b"c1 token is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/e8c6064d-8a05-4f24-95a2-913d7d8dbeb0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

