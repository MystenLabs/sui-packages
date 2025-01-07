module 0xb44e168c5669ce3c731ad30893f987d63f82b03f10f0c7d82358c1e0fb322a26::suiturtletweets {
    struct SUITURTLETWEETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITURTLETWEETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITURTLETWEETS>(arg0, 6, b"SuiTurtletweets", b"turtletweets", x"44656469636174656420746f2070726f74656374696e6720746872656174656e656420747572746c657320616e6420746f72746f6973657320616e6420746865697220686162697461747320776f726c64776964652c20616e6420746f2070726f6d6f74696e6720746865697220617070726563696174696f6e2062792070656f706c6520657665727977686572652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j_X3_Cyd33_400x400_a420a6d45a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITURTLETWEETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITURTLETWEETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

