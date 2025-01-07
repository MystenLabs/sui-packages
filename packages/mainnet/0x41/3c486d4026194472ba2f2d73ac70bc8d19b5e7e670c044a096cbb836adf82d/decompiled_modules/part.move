module 0x413c486d4026194472ba2f2d73ac70bc8d19b5e7e670c044a096cbb836adf82d::part {
    struct PART has drop {
        dummy_field: bool,
    }

    fun init(arg0: PART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PART>(arg0, 6, b"PART", b"PICSUI ART", b"New on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66a8985d8593e939e5fec968b70a436f_c2d7d079d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PART>>(v1);
    }

    // decompiled from Move bytecode v6
}

