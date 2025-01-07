module 0xe8b40ab5290ca71ecfc02580720381190f85f3be9352b09de8b8034cd088bb88::gochu {
    struct GOCHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOCHU>(arg0, 6, b"GOCHU", b"Sui Gochu", b"Gochu the new community  hub of spicy allurre!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002686_1f3cd65913.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOCHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOCHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

