module 0xdc1fd3ee9b16556d10f4dbc445866fb067f9ed162e08da6ac660bf32b7fb92ab::suilio {
    struct SUILIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIO>(arg0, 6, b"SUILIO", b"SUI LIO", b"a young lion from a wealthy family, squandered his inheritance due to an extravagant lifestyle and poor financial choices.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043809_4805df6071.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

