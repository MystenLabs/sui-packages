module 0x35d2483a9970c41af5fc39f29731c8e020cceef632be3fb47a24d37d7913bc0c::dsea {
    struct DSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSEA>(arg0, 6, b"DSEA", b"DolphiSea", b"$DSEA, inspired by the intelligence and speed of dolphins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731004885545.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

