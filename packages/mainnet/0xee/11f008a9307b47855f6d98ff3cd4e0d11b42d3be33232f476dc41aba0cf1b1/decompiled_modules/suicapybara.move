module 0xee11f008a9307b47855f6d98ff3cd4e0d11b42d3be33232f476dc41aba0cf1b1::suicapybara {
    struct SUICAPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAPYBARA>(arg0, 6, b"Suicapybara", b"capybara", b"swimming cute capybara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046206_a3ec13eb04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAPYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAPYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

