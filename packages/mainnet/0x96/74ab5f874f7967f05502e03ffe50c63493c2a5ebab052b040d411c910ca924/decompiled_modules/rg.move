module 0x9674ab5f874f7967f05502e03ffe50c63493c2a5ebab052b040d411c910ca924::rg {
    struct RG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RG>(arg0, 6, b"RG", b"RedGifs on SUI", x"4578706c6f726520796f7572206661766f7269746520636f6e74656e742063726561746f72732e206e6f20782c206e6f2074672e200a796f7572652077656c636f6d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_24_204327_c06ebbaca2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RG>>(v1);
    }

    // decompiled from Move bytecode v6
}

