module 0x2c081f2ed1079d86ff7b0036c90e8d06d1c1ec45a3f6f3eca022dd70b1530df6::testa {
    struct TESTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTA>(arg0, 6, b"Testa", b"Testb", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_27_15_10_53_3924a77a91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

