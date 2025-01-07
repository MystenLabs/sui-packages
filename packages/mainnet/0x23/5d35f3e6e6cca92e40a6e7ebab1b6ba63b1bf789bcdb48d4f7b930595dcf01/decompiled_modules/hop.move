module 0x235d35f3e6e6cca92e40a6e7ebab1b6ba63b1bf789bcdb48d4f7b930595dcf01::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"HOP", b"HOPIUM", x"596f2c206a75737420766962696ee2809920616c6f6e672077697468206d792024484f5049554d207768656e2073756464656e6c792e2e2e20f09f94a52057686f612c2067756573732074686174e280990a0a546865207469636b65722069732024484f5049554d3a204765742052696368206f722043727920547279696e67210a0a0a0a68747470733a2f2f782e636f6d2f686f7069756d66756e0a0a68747470733a2f2f686f7069756d7375692e636f6d0a0a68747470733a2f2f742e6d652f686f705f69756d706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731009604243.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

