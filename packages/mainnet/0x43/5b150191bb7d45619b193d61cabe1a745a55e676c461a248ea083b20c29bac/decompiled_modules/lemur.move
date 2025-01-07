module 0x435b150191bb7d45619b193d61cabe1a745a55e676c461a248ea083b20c29bac::lemur {
    struct LEMUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMUR>(arg0, 6, b"Lemur", b"Blue Eyed Lemur", b"A blue-eyed Lemur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_072013_12aea78d26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEMUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

