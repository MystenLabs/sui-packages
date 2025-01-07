module 0xac356658cf8b5ad98430b1046466b108b957968e12d3b5d07211aece70950bb1::sharko {
    struct SHARKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKO>(arg0, 6, b"Sharko", b"Sui Sharko", x"5361792068656c6c6f20746f20536861726b6f206f6e2053756921205769746820536861726b6f2c20796f75277265206e6f74206a7573742074726164696e672c20796f7527726520726964696e6720746865206d656d65207761766520616e6420686176696e67206120626c617374207768696c6520796f7520646f20697421204469766520696e746f206120736561206f66202066756e20616e642065706963206761696e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOVE_PROFILE_SHARKO_2_2c76470348.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

