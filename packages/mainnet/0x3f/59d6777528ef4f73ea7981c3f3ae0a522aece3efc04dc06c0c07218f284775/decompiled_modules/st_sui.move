module 0x3f59d6777528ef4f73ea7981c3f3ae0a522aece3efc04dc06c0c07218f284775::st_sui {
    struct ST_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST_SUI>(arg0, 9, b"ST_SUI", b"ST_SUI Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ST_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

