module 0x46ba21576d2475c6d0800ab894571940d59502258c74c24a07f286a737688c0f::suitest {
    struct SUITEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEST>(arg0, 6, b"SUITEST", b"Sui Test", b"Sui Test Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Liverpool_1_20b2c17057.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

