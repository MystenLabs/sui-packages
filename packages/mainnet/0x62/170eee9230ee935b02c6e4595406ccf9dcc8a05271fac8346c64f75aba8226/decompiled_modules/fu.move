module 0x62170eee9230ee935b02c6e4595406ccf9dcc8a05271fac8346c64f75aba8226::fu {
    struct FU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FU>(arg0, 6, b"FU", b"FUONSUI", b"The Chinese character Fu () means happiness, blessing, and good fortune", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme_Set_1_6481cbda33.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FU>>(v1);
    }

    // decompiled from Move bytecode v6
}

