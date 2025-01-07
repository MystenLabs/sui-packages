module 0x94992eb9cbc2d54e17976cac1824fdbc4ad7f7649cb26b28ab994960f58de3d5::r1v1 {
    struct R1V1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: R1V1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R1V1>(arg0, 6, b"R1V1", b"R1", b"Simple math", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731842316103.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R1V1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R1V1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

