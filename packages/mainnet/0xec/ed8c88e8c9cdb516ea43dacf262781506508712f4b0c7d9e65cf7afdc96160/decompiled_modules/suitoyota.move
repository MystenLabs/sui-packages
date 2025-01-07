module 0xeced8c88e8c9cdb516ea43dacf262781506508712f4b0c7d9e65cf7afdc96160::suitoyota {
    struct SUITOYOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOYOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOYOTA>(arg0, 6, b"SuiToyota", b"SUITOYOTA", b"Best chain best car", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1891_c5e66a5d09.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOYOTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOYOTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

