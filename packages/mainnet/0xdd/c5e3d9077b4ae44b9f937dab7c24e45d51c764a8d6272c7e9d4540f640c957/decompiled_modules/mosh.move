module 0xddc5e3d9077b4ae44b9f937dab7c24e45d51c764a8d6272c7e9d4540f640c957::mosh {
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

