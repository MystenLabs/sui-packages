module 0x786b4f154de06a599951c4ff22175308667ad190ba96c7602052680961a7c340::rt1 {
    struct RT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RT1>(arg0, 6, b"RT1", b"Rockey-test1", b"Rockey test1 meme on movepump, 100% CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069843_5e0670301a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RT1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RT1>>(v1);
    }

    // decompiled from Move bytecode v6
}

