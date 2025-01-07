module 0xa04bcb3301d3dd464a1861acaf2c613df187ae8bc4b052e302d755be72083c9f::axy {
    struct AXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXY>(arg0, 6, b"AXY", b"Axy Sui", x"24415859202d20546865204c6561646572206f6620746865204d696e69204d656d652043756c74200a4a6f696e2074686520234d696e694d656d6573206d6f76656d656e742120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048967_9f6c185e91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

