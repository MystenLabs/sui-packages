module 0x600ee199fd6011a61f3bad781a94085e8f04403705c89bf954046f2adec1d03b::fishi {
    struct FISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHI>(arg0, 6, b"Fishi", b"fishi", b"little $fishi living in a world of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0871_c96a4713d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

