module 0x52ca0f9f13acc4c482fd44959cd3c552bcd4e5314909235b6bb8913c8785d721::utya {
    struct UTYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTYA>(arg0, 6, b"UTYA", b"UTYA on Sui", b"$UTYA- the iconic duck emoji on sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_15_31_39_5fd80ad077.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UTYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

