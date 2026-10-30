module 0xe194e710c7773e989beacd233001898b58bd90fcd9f7b31e03511cf9a0caa07e::tvlp1 {
    struct TVLP1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVLP1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVLP1>(arg0, 6, b"TVLP1", b"TVLP1", b"TVLP1 LP coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TVLP1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVLP1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

