module 0x4d62220b9b226e4453515fcfc10baa924eb55cfe6eb803ee0cf3eaac10af5fae::suigilly {
    struct SUIGILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGILLY>(arg0, 6, b"SuiGilly", b"Sui-Gilly", x"47696c6c792074686520436f6c6c6563746f720a47696c6c7927732074686520666c6170706965737420736c69636b65722066726f6d2074686520776174657273206f662074686520706c616e6574205375692e20536865277320676f742074686520737065656420616e64206167696c69747920616e64206b6e6f777320686572207761792061726f756e6420616c6c206b696e6473206f6620626c6f636b7320616e6420746865697220636861696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Gilly_The_collector_943ad5da27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

