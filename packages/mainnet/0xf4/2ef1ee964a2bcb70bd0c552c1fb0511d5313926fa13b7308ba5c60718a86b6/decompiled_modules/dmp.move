module 0xf42ef1ee964a2bcb70bd0c552c1fb0511d5313926fa13b7308ba5c60718a86b6::dmp {
    struct DMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMP>(arg0, 6, b"DMP", b"Donald Trump Sui", b"Trump is king.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737295305180.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

