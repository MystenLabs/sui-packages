module 0x62004de1a8bdf8614d75b42e2639be98779c93928fea5e24273accbd809037a6::michi {
    struct MICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHI>(arg0, 6, b"MICHI", b"MICHI IN THE FRUIT", b"MICHI IN THE FRUIT ON SUI. TICKER: MICHI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9ddc261ebe0e15d07e7be38f4c9f9545_1700950656_df7516eedb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

