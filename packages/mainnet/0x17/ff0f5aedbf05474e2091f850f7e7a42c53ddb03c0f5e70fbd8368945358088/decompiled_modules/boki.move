module 0x17ff0f5aedbf05474e2091f850f7e7a42c53ddb03c0f5e70fbd8368945358088::boki {
    struct BOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOKI>(arg0, 6, b"BOKI", b"Bloki On Sui", x"424f4b49206973206d6f7265207468616e0a6a7573742061206d656d6520636f696e3b0a69742773206120636f6d6d756e697479206f660a6c696b652d6d696e6465640a696e646976696475616c732077686f0a7368617265206120636f6d6d6f6e0a6c6f766520666f72206361747320616e6420610a70617373696f6e20666f720a63727970746f63757272656e63696573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000363_05e9cd5ce5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

