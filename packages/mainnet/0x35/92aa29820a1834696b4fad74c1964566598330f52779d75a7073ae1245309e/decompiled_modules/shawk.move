module 0x3592aa29820a1834696b4fad74c1964566598330f52779d75a7073ae1245309e::shawk {
    struct SHAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAWK>(arg0, 6, b"SHAWK", b"SHAWK SUI", b"New Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6735_7f7467e690.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

