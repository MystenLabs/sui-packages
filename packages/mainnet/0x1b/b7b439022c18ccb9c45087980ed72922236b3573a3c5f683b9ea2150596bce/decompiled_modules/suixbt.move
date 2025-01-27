module 0x1bb7b439022c18ccb9c45087980ed72922236b3573a3c5f683b9ea2150596bce::suixbt {
    struct SUIXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIXBT>(arg0, 6, b"SUIXBT", b"suixbt by SuiAI", b"Y", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pixlr_image_generator_bfe945a9_8485_4081_a5a6_844d0013835a_baaaad8e26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIXBT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXBT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

