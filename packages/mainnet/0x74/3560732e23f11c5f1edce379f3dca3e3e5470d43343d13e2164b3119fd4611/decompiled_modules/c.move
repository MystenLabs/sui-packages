module 0x743560732e23f11c5f1edce379f3dca3e3e5470d43343d13e2164b3119fd4611::c {
    struct C has drop {
        dummy_field: bool,
    }

    fun init(arg0: C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C>(arg0, 6, b"C", b"COIN", b"COIN is a token dedicated to preserve cryptocurrency. The owner's wish is for it to be used as a shared metric of the world's sentiment towards cryptocurrency. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755903950930.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<C>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

