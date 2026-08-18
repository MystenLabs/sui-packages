module 0xe3932656a49a3a89ff949cacd563a404949687ec04b6770d3ed759e145c1350d::ferfe {
    struct FERFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERFE>(arg0, 6, b"FERFE", b"ergfe", b"erfer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FERFE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERFE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

