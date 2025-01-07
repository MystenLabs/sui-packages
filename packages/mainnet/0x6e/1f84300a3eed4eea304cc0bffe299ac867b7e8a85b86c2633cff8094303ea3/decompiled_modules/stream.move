module 0x6e1f84300a3eed4eea304cc0bffe299ac867b7e8a85b86c2633cff8094303ea3::stream {
    struct STREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STREAM>(arg0, 6, b"STREAM", b"Streamcat", x"48692069276d2073747265616d206361742c206d7573696320636f6e6e6f69737365757273206174207468652073616d652074696d652077616e7420746f2067657420746f206b6e6f772074686520776f726c64206f662063727970746f63757272656e6369657320616e64206d656d65636f696e206d6f726520776964656c790a0a4a6f696e206f75722074656c656772616d3a20742e6d652f53747265616d636174636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053695_34ed675abd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

