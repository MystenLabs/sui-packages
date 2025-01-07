module 0x805b63734f4d79c18bb7f7168363db0cef6d5ba4eaf84284b2bf52c062ff6c1d::jokers {
    struct JOKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKERS>(arg0, 6, b"JOKERS", b"Joker Sui Fun", b"Make Sui strong.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_4_89bd5ddc68.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

