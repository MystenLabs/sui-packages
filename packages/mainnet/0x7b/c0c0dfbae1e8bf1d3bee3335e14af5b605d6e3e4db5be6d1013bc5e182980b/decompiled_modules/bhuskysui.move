module 0x7bc0c0dfbae1e8bf1d3bee3335e14af5b605d6e3e4db5be6d1013bc5e182980b::bhuskysui {
    struct BHUSKYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHUSKYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHUSKYSUI>(arg0, 6, b"BHUSKYSUI", b"BHUSKY", b"Bhusky is the first and only husky on the Base network. Known for his friendly and playful nature, Bhusky is a symbol of community and togetherness. Hes not here to racehes here to bring people together, making crypto a more enjoyable and relatable experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BASELEME_0c760c62ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHUSKYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHUSKYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

