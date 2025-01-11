module 0xa6195a1fd1b9456a0d78b49e3b2cbfa6faba810befc98100c3f474393fdd7a1c::titty {
    struct TITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITTY>(arg0, 6, b"Titty", b"Milk shake", b"my milkshake brings all the degens to the yard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250112_035846_956_6e07abfad9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

