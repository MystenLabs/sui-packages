module 0xed13635f8456246d241a724a92731b8463390b6953516fed5d627ecd5590f07a::sumire {
    struct SUMIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMIRE>(arg0, 6, b"SUMIRE", b"SUMIRE - the Two-legged DOGE/Shiba", b" the Two-legged DOGE/Shiba ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_07_55_55_6e9bca6bd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

