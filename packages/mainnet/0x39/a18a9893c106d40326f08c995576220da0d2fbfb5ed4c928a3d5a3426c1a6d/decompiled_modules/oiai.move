module 0x39a18a9893c106d40326f08c995576220da0d2fbfb5ed4c928a3d5a3426c1a6d::oiai {
    struct OIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIAI>(arg0, 6, b"OiAi", b"Olivia AI", x"4f6c69766961204149200a537569206973206261636b207769746820796f752074686520626c6f636b636861696e206e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017893_5f966f29a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

