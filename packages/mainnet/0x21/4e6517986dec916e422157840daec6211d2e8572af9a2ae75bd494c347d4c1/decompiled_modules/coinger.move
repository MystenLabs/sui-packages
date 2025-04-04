module 0x214e6517986dec916e422157840daec6211d2e8572af9a2ae75bd494c347d4c1::coinger {
    struct COINGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINGER>(arg0, 9, b"COINGER", b"Coin", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6c6d14bda2c2439d4c890abd4e8a2ff9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINGER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINGER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

