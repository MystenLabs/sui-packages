module 0xab6e54d87b153c8ebe3f722ea3c90bd243a77c7007448822125c173c03010106::deep_test {
    struct DEEP_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP_TEST>(arg0, 6, b"DEEP_TEST", b"DEEP Token Test", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"xxx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEP_TEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP_TEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

