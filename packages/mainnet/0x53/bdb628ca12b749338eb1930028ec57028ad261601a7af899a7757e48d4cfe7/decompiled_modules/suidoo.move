module 0x53bdb628ca12b749338eb1930028ec57028ad261601a7af899a7757e48d4cfe7::suidoo {
    struct SUIDOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOO>(arg0, 6, b"SUIDOO", b"Scooby Doo on Sui", b"Scooby Doo on Sui $SUIDOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_11_48_26_535e35f0f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

