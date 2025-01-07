module 0xfcd39095866d800e5058ef750d9e2c5be8e972e64fe95990eb4eb0d356898c0d::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 6, b"S", b"SiqSagSoh", b"SS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731372030334.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

