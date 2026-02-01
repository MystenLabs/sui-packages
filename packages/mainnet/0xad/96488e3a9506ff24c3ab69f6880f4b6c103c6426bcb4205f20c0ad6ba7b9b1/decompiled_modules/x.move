module 0xad96488e3a9506ff24c3ab69f6880f4b6c103c6426bcb4205f20c0ad6ba7b9b1::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 6, b"X", b"ProjectX", b"pROxajq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1769986576670.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

