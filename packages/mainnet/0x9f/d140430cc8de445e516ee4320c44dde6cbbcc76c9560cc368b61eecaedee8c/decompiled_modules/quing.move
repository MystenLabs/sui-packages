module 0x9fd140430cc8de445e516ee4320c44dde6cbbcc76c9560cc368b61eecaedee8c::quing {
    struct QUING has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUING>(arg0, 9, b"QUING", b"QUING", b"QUING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"QUING")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUING>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUING>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<QUING>>(v2);
    }

    // decompiled from Move bytecode v6
}

