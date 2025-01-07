module 0x4c4a667704495f728061fb7560f5b44945b85fa749febb8d1118b7f5a8327085::kabal {
    struct KABAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABAL>(arg0, 6, b"Kabal", b"Kabala Harris", b"Are you on the right side?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_17_16_19_00_7615c17469.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

