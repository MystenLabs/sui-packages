module 0xfa80526cb05ac28c57c6c8abbff813f8b8fdb6c120ce74931efb2fdc882dffa5::bul {
    struct BUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUL>(arg0, 6, b"BUL", b"Bul", x"4174202442554c2c207765e280997265206e6f74206a75737420616e6f7468657220746f6b656e206f6e2074686520626c6f636be280947765e280997265206120706f776572686f75736520636f6d6d756e697479206f662062756c6c73206f6e2061206d6f6f6e206d697373696f6e21204a6f696e20746865206368617267652c207468657265e2809973206e6f2062756c72756e20776974686f757420746865202462756c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731246401927.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

