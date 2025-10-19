module 0x20423e14df16b375fbad5a7c8187832b69e80e519de8293d07042344b585d967::t408702 {
    struct T408702 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T408702, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T408702>(arg0, 9, b"T408702", b"Test 408702", b"Integration test token 2025-10-19T22:53:28.702Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T408702>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T408702>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

