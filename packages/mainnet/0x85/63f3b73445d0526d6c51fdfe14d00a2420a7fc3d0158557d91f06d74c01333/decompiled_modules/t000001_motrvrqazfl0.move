module 0x8563f3b73445d0526d6c51fdfe14d00a2420a7fc3d0158557d91f06d74c01333::t000001_motrvrqazfl0 {
    struct T000001_MOTRVRQAZFL0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T000001_MOTRVRQAZFL0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T000001_MOTRVRQAZFL0>(arg0, 9, b"T000001", b"Test000001", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmUDbgmzaBxuaHjXVBjmkdCnJFRMryKRxbV4TfWjFaz8u6")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T000001_MOTRVRQAZFL0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T000001_MOTRVRQAZFL0>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

