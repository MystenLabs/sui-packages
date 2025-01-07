module 0xdc489ec4d7c93f5205d3fc9194aab939d33a8f104b4d5255fe3a0f207601fd22::suilpaca {
    struct SUILPACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILPACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILPACA>(arg0, 6, b"SUILPACA", b"ALPACA ON SUI", b"the adventurous blue alpaca who dives deep into the ocean's mysteries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/instant_53_3afad69116.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILPACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILPACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

