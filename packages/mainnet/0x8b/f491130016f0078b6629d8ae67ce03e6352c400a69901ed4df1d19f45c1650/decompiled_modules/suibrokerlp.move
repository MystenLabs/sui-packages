module 0x8bf491130016f0078b6629d8ae67ce03e6352c400a69901ed4df1d19f45c1650::suibrokerlp {
    struct SUIBROKERLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBROKERLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBROKERLP>(arg0, 6, b"SUIBROKERLP", b"SUIBROKERSLP", b"SUIBROKERS LP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBROKERLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBROKERLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

