module 0x87c7bc6f8b09925b3ab011366a1e02e1202a34f7ff5e2c2dce7c8e5966915e3b::batmew {
    struct BATMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATMEW>(arg0, 6, b"BATMEW", b"Sui Superhero", x"4241544d4557206973206120756e69717565206d656d65636f696e207468617420626c656e64732066756e20776974682066756e6374696f6e616c6974792e0a0a496e73706972656420627920746865206e65656420666f72206d6f726520736563757269747920696e207468652063727970746f2073706163652c204241544d4557206973206f6e2061206d697373696f6e20746f206669676874207363616d7320616e64207275672070756c6c732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048548_b5fea89860.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

