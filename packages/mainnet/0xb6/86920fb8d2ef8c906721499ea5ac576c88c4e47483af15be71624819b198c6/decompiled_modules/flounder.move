module 0xb686920fb8d2ef8c906721499ea5ac576c88c4e47483af15be71624819b198c6::flounder {
    struct FLOUNDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOUNDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOUNDER>(arg0, 6, b"Flounder", b"Flounder Fish", x"57687920466c6f756e64657220697320696d706f7274616e7420746f20746865205375692045636f73797374656d3f0a466c6f756e6465722073657276657320617320626f74682061206d6f76656d656e7420616e642061206d61726b6574696e6720746f6f6c2c2064726976696e6720656e676167656d656e742061726f756e64207374616b696e67206f6e205375692e20546865206f6666696369616c206163636f756e742077696c6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ffish1_216e5122b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOUNDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOUNDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

