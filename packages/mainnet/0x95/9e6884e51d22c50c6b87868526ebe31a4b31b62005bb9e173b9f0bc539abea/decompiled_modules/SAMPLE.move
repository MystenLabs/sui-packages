module 0x959e6884e51d22c50c6b87868526ebe31a4b31b62005bb9e173b9f0bc539abea::SAMPLE {
    struct SAMPLE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAMPLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAMPLE>>(0x2::coin::mint<SAMPLE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SAMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMPLE>(arg0, 9, b"SAMPLE", b"Sample Coin", b"Description of Sample Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMPLE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAMPLE>>(v2);
    }

    // decompiled from Move bytecode v6
}

