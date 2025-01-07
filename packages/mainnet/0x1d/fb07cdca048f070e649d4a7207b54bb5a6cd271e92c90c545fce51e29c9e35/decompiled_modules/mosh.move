module 0x1dfb07cdca048f070e649d4a7207b54bb5a6cd271e92c90c545fce51e29c9e35::mosh {
    struct MOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSH>(arg0, 6, b"Mosh", b"Mo Shaikh", b"luk at dis duuuuude", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mo_Shaikh_d4f73fe8f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

