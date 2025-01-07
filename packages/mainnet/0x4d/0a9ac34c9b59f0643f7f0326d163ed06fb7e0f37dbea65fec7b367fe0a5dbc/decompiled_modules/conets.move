module 0x4d0a9ac34c9b59f0643f7f0326d163ed06fb7e0f37dbea65fec7b367fe0a5dbc::conets {
    struct CONETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONETS>(arg0, 6, b"CoNetS", b"CoNetsui Network", x"57656c636f6d6520746f2074686520436f4e455420436f6d6d756e69747921200a0a436f4e4554206973206120446550494e2070726f6a65637420706f7765726564206279204c61796572204d696e75732050726f746f636f6c2c206275696c7420666f72207072697661637920616e6420646563656e7472616c697a6174696f6e2e204561726e2062792073686172696e67207265736f757263657320696e2061207365637572652c20757365722d64726976656e206e6574776f726b2077697468207265616c2d776f726c64207574696c6974792e0a0a4a756d7020696e2c206578706c6f72652c20616e64207374617274206561726e696e6721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049312_a9477a49ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

