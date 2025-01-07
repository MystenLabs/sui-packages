module 0x6716789770ac6b1046d5943d3335c41c85d50c7d7443a786106c3a82411d1a5e::suitinder {
    struct SUITINDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITINDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITINDER>(arg0, 6, b"SUITINDER", b"Sui Tinder", b"Here you can match the best memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Tinder_perf_25563c5047.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITINDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITINDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

