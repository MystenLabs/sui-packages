module 0x1053ad3fe175ae92ac5f4eb190881cbbaed516289ac558cd78769514922c0742::falika_sui {
    struct FALIKA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALIKA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALIKA_SUI>(arg0, 9, b"falikaSUI", b"Falika Staked SUI", b"Falika is a test project in support of ika", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/28b5dbeb-36db-44d7-bb5a-53847ce8485e/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALIKA_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FALIKA_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

