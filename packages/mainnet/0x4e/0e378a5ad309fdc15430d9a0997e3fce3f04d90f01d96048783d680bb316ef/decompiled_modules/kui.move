module 0x4e0e378a5ad309fdc15430d9a0997e3fce3f04d90f01d96048783d680bb316ef::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 6, b"KUI", b"SharKui", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736278166417.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

