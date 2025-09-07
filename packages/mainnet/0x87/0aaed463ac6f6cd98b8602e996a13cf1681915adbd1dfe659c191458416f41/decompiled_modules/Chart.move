module 0x870aaed463ac6f6cd98b8602e996a13cf1681915adbd1dfe659c191458416f41::Chart {
    struct CHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHART>(arg0, 9, b"MEGA", b"Chart", b"mega chart ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0PMQX8XoAE4ISw?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

