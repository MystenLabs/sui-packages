module 0xf3fb919331a28e28cf1971345a6de9b4301dcee101d327c32d71ced5bb654bd3::suichan {
    struct SUICHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAN>(arg0, 6, b"SUICHAN", b"Sui-Chan", x"5768697370657273206f6620697473206e616d65206361707469766174652074686520626f6c642e0a49747320636f6d696e672c206272696e67696e6720636861726d6f7220706f776572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T4_TRKL_2_I_400x400_1_5c3c9c8401.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

