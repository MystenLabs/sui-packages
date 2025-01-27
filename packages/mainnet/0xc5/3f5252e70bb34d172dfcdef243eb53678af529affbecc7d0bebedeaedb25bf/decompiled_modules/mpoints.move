module 0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints {
    struct MPOINTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPOINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPOINTS>(arg0, 0, b"mPOINTS", b"mPOINTS", b"Metastable points Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/mpoints.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPOINTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPOINTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

