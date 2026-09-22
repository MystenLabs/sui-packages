module 0x50146e162fba28579644636123e9d92affe5ea73237573d3dd8ab7783007726a::dram {
    struct DRAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAM>(arg0, 6, b"DRAM", b"DRAM", b"ZO Virtual Coin for DRAM", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAM>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DRAM>>(v0);
    }

    // decompiled from Move bytecode v7
}

