module 0x6ac0404010e01c6b87a77a86d92c1a37ea1d31be17b4c92969df580dc97e9d47::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 6, b"TEST1", b"TEST 1", b"teST 1 !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731029257158.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

