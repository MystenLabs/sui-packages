module 0xdeaa1abfe8d3d05e0c4c463e52e9645931ae4797d48072fe88f21eba819182e0::std {
    struct STD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STD>(arg0, 6, b"STD", b"Save the dog", x"74686520707572706f736520616e642070726f6669742077696c6c20626520676976656e20656e746972656c7920746f20646f67206272656564657273206f7220686f73706974616c732061726f756e642074686520776f726c642c20616e64206f7468657220616e696d616c730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053889_ecafb62587.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STD>>(v1);
    }

    // decompiled from Move bytecode v6
}

