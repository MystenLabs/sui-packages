module 0x97af18930a64857ce963693b571d4b68c46814f7d08f1cd4ec88c381bc3c6c5a::d {
    struct D has drop {
        dummy_field: bool,
    }

    fun init(arg0: D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D>(arg0, 6, b"D", b"c", b"e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

