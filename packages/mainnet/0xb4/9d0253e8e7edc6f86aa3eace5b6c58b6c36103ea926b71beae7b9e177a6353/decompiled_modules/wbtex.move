module 0xb49d0253e8e7edc6f86aa3eace5b6c58b6c36103ea926b71beae7b9e177a6353::wbtex {
    struct WBTEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTEX>(arg0, 18, b"WBTEX", b"Whale Bridge Token Example", b"Attacker-controlled decimals for bridge register_foreign_token probe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://whale.invalid/wbtex")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTEX>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WBTEX>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

