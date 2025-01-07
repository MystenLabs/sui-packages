module 0x99c32a4db0dfd18c0049042fea069c75872f819b10f19533e3d4858c1e2e07f5::kermi {
    struct KERMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMI>(arg0, 6, b"KERMI", b"Kerminator", x"486520746f6c642075732068652077696c6c206265206261636b2e2e2e2e2e206275742077686f20776f756c642776652074686f7567687420686520776f756c6420636f6d65206261636b20696e206b65726d6974207468652066726f677320666f726d3f0a55206c696b65206b65726d69743f2859455329202055206c696b6520746865207465726d696e61746f72202859455329207468656e20796f752073686f756c64206c6f7665204b65726d696e61746f72210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_00dac98590.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

