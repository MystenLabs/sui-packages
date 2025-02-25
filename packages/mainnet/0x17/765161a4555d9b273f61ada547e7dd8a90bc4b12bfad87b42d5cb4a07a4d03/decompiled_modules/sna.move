module 0x17765161a4555d9b273f61ada547e7dd8a90bc4b12bfad87b42d5cb4a07a4d03::sna {
    struct SNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNA>(arg0, 6, b"SNA", b"Snake Coin", x"536e616b6520436f696e2063616e206265636f6d6520746865206d61696e2063757272656e637920696e20626c6f636b636861696e2067616d65732c20657370656369616c6c792067616d6573206261736564206f6e2074686520e2809c536e616b65206f662050726579e2809d207468656d652e0a506c61796572732063616e206561726e20536e616b6520436f696e7320627920636f6d706c6574696e67206d697373696f6e732c2070617274696369706174696e6720696e206576656e74732c206f72206669676874696e67206f7468657220706c6179657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/9139d0be-2eed-4a4c-b298-e16098016f49.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

