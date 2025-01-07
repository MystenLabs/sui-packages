module 0x22ae2aa14b554929d26481eda4579f37f851969e4ae1733236c81caf2fc3ed65::tsc {
    struct TSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSC>(arg0, 6, b"TSC", b"Turkish Stray Cat", x"4f7572204d697373696f6e203f20546f2073656e64207468697320746f20746865206d6f6f6e2120576879203f20426563617573652077652061726520646f6e6174696e6720746865204465762077616c6c657420636f6d706c6574656c7920746f2061206c6f63616c20616e696d616c207368656c74657220696e206e6565642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_155631_006_1435c01fe8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

