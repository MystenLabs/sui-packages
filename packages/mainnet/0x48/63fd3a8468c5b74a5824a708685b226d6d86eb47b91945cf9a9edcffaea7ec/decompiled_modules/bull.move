module 0x4863fd3a8468c5b74a5824a708685b226d6d86eb47b91945cf9a9edcffaea7ec::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 9, b"Bull", b"BullRun", b"2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/63e8856acdea42218f0e6def4b9bffd8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

