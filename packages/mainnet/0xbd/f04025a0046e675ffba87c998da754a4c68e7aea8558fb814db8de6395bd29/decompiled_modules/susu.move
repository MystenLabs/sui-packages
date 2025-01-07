module 0xbdf04025a0046e675ffba87c998da754a4c68e7aea8558fb814db8de6395bd29::susu {
    struct SUSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSU>(arg0, 6, b"SUSU", b"SUSUMEOW", b"SUSU CAT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_sketch_da_tutorial_by_softpeachys_dfxzggp_414w_2x_7f39777a70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

