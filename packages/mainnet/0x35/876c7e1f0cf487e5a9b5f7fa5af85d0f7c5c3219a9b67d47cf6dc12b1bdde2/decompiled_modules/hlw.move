module 0x35876c7e1f0cf487e5a9b5f7fa5af85d0f7c5c3219a9b67d47cf6dc12b1bdde2::hlw {
    struct HLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLW>(arg0, 6, b"HLW", b"Hello world", b"Test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/daossui/assets/tokens/531443a95b484bdc8ed52345b310960b")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLW>>(v1);
        0x2::coin::mint_and_transfer<HLW>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLW>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

