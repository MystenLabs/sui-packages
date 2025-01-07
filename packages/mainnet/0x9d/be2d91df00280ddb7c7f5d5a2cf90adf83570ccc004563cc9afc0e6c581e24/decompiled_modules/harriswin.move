module 0x9dbe2d91df00280ddb7c7f5d5a2cf90adf83570ccc004563cc9afc0e6c581e24::harriswin {
    struct HARRISWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRISWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRISWIN>(arg0, 6, b"HARRISWIN", b"HARRIS WIN", b"Kamala Harris or Donald Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/licensed_image_1_8ab21e21e7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRISWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRISWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

