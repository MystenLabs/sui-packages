module 0x33e76b9648e4c64ef8a066242fce6f621337a9882f786db96898e07b3ec39ca0::stb {
    struct STB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STB>(arg0, 6, b"STB", b"Sui The Bob", b"My Name is Robert but you can call me Bob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOB_THE_BLOB_6f3b505836.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STB>>(v1);
    }

    // decompiled from Move bytecode v6
}

