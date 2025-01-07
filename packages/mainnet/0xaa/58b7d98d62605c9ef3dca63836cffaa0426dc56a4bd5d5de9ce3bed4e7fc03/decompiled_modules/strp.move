module 0xaa58b7d98d62605c9ef3dca63836cffaa0426dc56a4bd5d5de9ce3bed4e7fc03::strp {
    struct STRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRP>(arg0, 6, b"STRP", b"SUITRUMP", b"Trump on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731270955983.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

