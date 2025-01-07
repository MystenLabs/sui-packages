module 0xb10770b0ed72a983c9c56c5892ccb16e4ba48aca95919f03ee562413c4573b2e::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 6, b"Suidoge", b"super sui doge", x"5468652073756920646f676520676f696e6720746f206c696674207570207468652073756920746f2074686520736f6c616e617320706c616365200a536c6f67616e0a2a4772656174207375690a2a42657374207375690a2a537570657220737569200a2a5472656e64696e6720737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000155672_42916fa14c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

