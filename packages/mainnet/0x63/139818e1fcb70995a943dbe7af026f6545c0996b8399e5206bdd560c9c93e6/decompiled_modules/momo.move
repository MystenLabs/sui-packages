module 0x63139818e1fcb70995a943dbe7af026f6545c0996b8399e5206bdd560c9c93e6::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"MOMO", b"Momo On Sui", x"4d6f6d6f204f6e205375690a68747470733a2f2f6d6f6d6f2d636f696e2e6c6f6c2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_21_19_23_d3380616d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

