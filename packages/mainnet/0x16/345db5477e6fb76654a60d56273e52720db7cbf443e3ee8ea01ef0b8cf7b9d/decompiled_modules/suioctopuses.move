module 0x16345db5477e6fb76654a60d56273e52720db7cbf443e3ee8ea01ef0b8cf7b9d::suioctopuses {
    struct SUIOCTOPUSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOCTOPUSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOCTOPUSES>(arg0, 6, b"SuiOctopuses", b"octopuses", b"Octopuses on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_07_53_00_e9baec9a8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOCTOPUSES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOCTOPUSES>>(v1);
    }

    // decompiled from Move bytecode v6
}

