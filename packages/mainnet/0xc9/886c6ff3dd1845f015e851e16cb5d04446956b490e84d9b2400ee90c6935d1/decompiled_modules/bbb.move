module 0xc9886c6ff3dd1845f015e851e16cb5d04446956b490e84d9b2400ee90c6935d1::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 6, b"BBB", b"AAA", b"3RGFRE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

