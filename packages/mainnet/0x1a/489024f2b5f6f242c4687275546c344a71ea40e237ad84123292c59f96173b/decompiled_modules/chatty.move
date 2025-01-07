module 0x1a489024f2b5f6f242c4687275546c344a71ea40e237ad84123292c59f96173b::chatty {
    struct CHATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHATTY>(arg0, 6, b"CHATTY", b"CHATTY ON SUI", b"Meet $CHATTY the official community ChatGPTApp mascot! You ask what wall? There is no wall. Brought to you by SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_G_Xo_T6ys_400x400_4fc9d6ef06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

