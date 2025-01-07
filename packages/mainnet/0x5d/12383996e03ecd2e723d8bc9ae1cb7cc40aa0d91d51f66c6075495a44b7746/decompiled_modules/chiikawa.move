module 0x5d12383996e03ecd2e723d8bc9ae1cb7cc40aa0d91d51f66c6075495a44b7746::chiikawa {
    struct CHIIKAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIIKAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIIKAWA>(arg0, 6, b"Chiikawa", b"Chiikawa On Sui", b"Smol and Cute: https://chiikawaonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_2_2c4930c4bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIIKAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIIKAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

