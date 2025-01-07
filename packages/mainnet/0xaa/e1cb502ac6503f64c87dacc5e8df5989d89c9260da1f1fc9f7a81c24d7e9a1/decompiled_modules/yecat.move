module 0xaae1cb502ac6503f64c87dacc5e8df5989d89c9260da1f1fc9f7a81c24d7e9a1::yecat {
    struct YECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YECAT>(arg0, 6, b"YECAT", b"Yellow Cat on Sui", b"Just a yellow Cat on SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ddddddddddd3_d018dee229.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

