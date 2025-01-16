module 0xb49f7f50588561e9ff876c863d944000ee2b40285f4287f463324be5ffd77e29::ssai {
    struct SSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAI>(arg0, 6, b"SSAI", b"Suisense", x"53756953656e7365414920697320616e20696e74656c6c6967656e7420677569646520666f72207468652053756920626c6f636b636861696e2c2073696d706c696679696e6720636f6d706c657820696465617320616e642064656c69766572696e67206b657920696e73696768747320746f2053756920656e7468757369617374732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1737028280818_1611bb6c8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

