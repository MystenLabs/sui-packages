module 0x2bc0e02fa8bcd38358f8f61d4b6fc1177e79448eb639952b4333fea210dc493::suibrokerslp {
    struct SUIBROKERSLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBROKERSLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBROKERSLP>(arg0, 6, b"SUIBROKERSLP", b"SUIBROKERS LP", b"SUIBROKERS DESK LP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBROKERSLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBROKERSLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

