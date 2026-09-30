module 0xa147ed9a354cf914298d92a68b09295058f0aa7aec3ed959b73876ea97687200::work {
    struct WORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORK>(arg0, 9, b"work", b"working", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WORK>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORK>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

