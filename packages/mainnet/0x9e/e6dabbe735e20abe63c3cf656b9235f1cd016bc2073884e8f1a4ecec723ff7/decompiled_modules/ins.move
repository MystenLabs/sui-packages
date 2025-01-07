module 0x9ee6dabbe735e20abe63c3cf656b9235f1cd016bc2073884e8f1a4ecec723ff7::ins {
    struct INS has drop {
        dummy_field: bool,
    }

    fun init(arg0: INS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INS>(arg0, 6, b"INS", b"Inside Crypto", b"No words, just emotions. First emotion coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/INS_6c0fc5fcff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INS>>(v1);
    }

    // decompiled from Move bytecode v6
}

