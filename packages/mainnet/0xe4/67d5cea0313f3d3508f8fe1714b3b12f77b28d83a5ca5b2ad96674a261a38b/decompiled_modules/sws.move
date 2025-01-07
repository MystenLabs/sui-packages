module 0xe467d5cea0313f3d3508f8fe1714b3b12f77b28d83a5ca5b2ad96674a261a38b::sws {
    struct SWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWS>(arg0, 6, b"SWS", b"Sui Warrior", x"4d6565742053706c617368636c61772c20746865206f6e6c792077617272696f72206361742077686f2063616e206c69746572616c6c792064726f776e206f7574206869732070726f626c656d732e0a48657320676f742067696c6c732c206120626174746c652d73636172726564207461696c2c20616e64207374696c6c206861746573207761746572206669676874730a4c65747320686f706520686520646f65736e277420636c617720746865207469646521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CAT_SHARK_c741ac3fe9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

