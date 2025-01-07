module 0xa73fc50d20af6e6fc82bc61a762e4b9f331312518b46a912dc18d7bc53e0a553::suilder {
    struct SUILDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILDER>(arg0, 6, b"SUILDER", b"Suilder", x"5468652063727970746f207472656e6368657320617265206e6f20706c61636520666f7220746865207765616b2c2062757420666f72205375696c646965722c20697473206a75737420616e6f746865722064617920696e2074686520646567656e20776172207a6f6e652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img_hlogo_bdc2e8ea3a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

