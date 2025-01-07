module 0xfb92f12cefe8b038ef0a0dc635b2e5bf14acab4c57beac147177157177d67ed8::chain {
    struct CHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAIN>(arg0, 6, b"CHAIN", b"Chain Breaker AI", x"5468697320697320616e206164766572746973696e672070757368204f4e4c592020776520617265206e6f742070726f6d6f74696e6720616e7920636f696e2e0a0a496e74726f647563696e6720746865206e65776573742044455853637265656e6572207265616374696f6e20626f743a20436861696e20427265616b6572204149210a4e65656420726f636b65747320666f7220796f757220746f6b656e3f205468697320626f742068617320796f7520636f7665726564210a0a436c69636b20746865205447206c696e6b20666f72206469726563742061636365737320746f2074686520626f74204f4e4c592e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006642_cf4ab05f58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

