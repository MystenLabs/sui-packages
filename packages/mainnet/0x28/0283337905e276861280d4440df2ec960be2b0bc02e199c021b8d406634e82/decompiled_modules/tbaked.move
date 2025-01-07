module 0x280283337905e276861280d4440df2ec960be2b0bc02e199c021b8d406634e82::tbaked {
    struct TBAKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBAKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBAKED>(arg0, 6, b"TBAKED", b"TeddyBaked", b"LETS BAKED SOME PAPER BILLSSSS!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BAKED_f2585340cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBAKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBAKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

