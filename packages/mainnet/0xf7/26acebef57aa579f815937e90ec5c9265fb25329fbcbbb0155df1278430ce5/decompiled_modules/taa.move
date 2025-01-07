module 0xf726acebef57aa579f815937e90ec5c9265fb25329fbcbbb0155df1278430ce5::taa {
    struct TAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAA>(arg0, 6, b"TAA", b"aaa tusk", b"Tusk The Walrus Taaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1211_3b2b751b5b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

