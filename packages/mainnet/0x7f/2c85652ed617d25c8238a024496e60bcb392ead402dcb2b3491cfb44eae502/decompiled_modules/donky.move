module 0x7f2c85652ed617d25c8238a024496e60bcb392ead402dcb2b3491cfb44eae502::donky {
    struct DONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKY>(arg0, 6, b"DONKY", b"Sdonky", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://koi.family/api/images/ffc3dc3972d2c2b305e43c4fc5715cc52d9f73a74a00f6809ef12c892a3c2755.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKY>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONKY>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

