module 0xe35e518c1e830aedf47884fa3b7a3fb2563e4281faf462e0bd4905b083b8b22d::nodes {
    struct NODES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NODES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NODES>(arg0, 6, b"NODES", b"Nodes Protocol ", x"57687920244e4f4445533f20576879204e6f6465732050726f746f636f6c203f20416476616e6365642045636f73797374656d20e28094204e6f6465732050726f746f636f6c207365616d6c6573736c7920696e746567726174657320626c6f636b636861696e20616e6420414920746563686e6f6c6f676965732c206f66666572696e6720612063757474696e672d6564676520706c6174666f726d20666f72206275696c64696e6720616e64206d616e6167696e67207370656369616c697a6564207375626e657473206f7074696d697a656420666f722064697665727365206469676974616c20636f6d6d6f6469746965732e204571756974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736167829094.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NODES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NODES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

