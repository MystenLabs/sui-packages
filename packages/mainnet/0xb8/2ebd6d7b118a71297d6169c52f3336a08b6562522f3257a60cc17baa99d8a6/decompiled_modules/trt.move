module 0xb82ebd6d7b118a71297d6169c52f3336a08b6562522f3257a60cc17baa99d8a6::trt {
    struct TRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRT>(arg0, 6, b"trt", b"tttt", b"ttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

