module 0x81ef2aaba7807ecab4eba9aa6e8a48fa0a5a33edfd77b969c055d55e8e904dcb::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"CHILL", b"Chill dog", b"Just a chill dog sitting chilling in the water with a beer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_30_20_25_52_f4c3729f20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

