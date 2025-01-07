module 0x1535327feea27989be3fdd379c962f9268851a38b2b5a08b6eb1108bb0fe82bd::tete {
    struct TETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETE>(arg0, 6, b"TETE", b"TETE Token", b"TETE Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ad_special_price_5833aa6348.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETE>>(v1);
    }

    // decompiled from Move bytecode v6
}

