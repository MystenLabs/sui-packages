module 0x97409ac891650e89b584554e28f9fcea66ad84def0c5f71ab5f7293a184e0701::suilon {
    struct SUILON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILON>(arg0, 6, b"SUILON", b"ELON on SUI", x"245355494c4f4e2077696c6c206d616b652053554920677265617420616761696e20210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/18_S4u_NCI_400x400_1079ab94b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILON>>(v1);
    }

    // decompiled from Move bytecode v6
}

