module 0xb36d28e218d54005ead189cd326b02401d44cdaac9499329dd23da6f0028fa33::am {
    struct AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM>(arg0, 0xe2c31b248b3495b9c41e2ed6080b23ea9cfa1b0c615e2a5e4984548e2a316972::constants::lp_decimals(), b"AM", b"Andy", b"Andy coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

