module 0x788f0f56e5b6ca125b999cbcc584072a61bd4dfa6bee432834a2778556647050::castle {
    struct CASTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASTLE>(arg0, 6, b"CASTLE", b"Sand Castle of Sui", x"4275696c7420666f72207468652062656163682c206c6976696e67206f6e2074686520626c6f636b636861696e2e2053616e6420436173746c65206f662053756920686f6c64732074686520666f727420696e20746865205375692064756e65732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_85_5257561da4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

