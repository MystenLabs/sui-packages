module 0xc8ad6384d8a4f3c96b203afce84a3cebb14fb54ad86e8e1145e29fb704171c90::escd {
    struct ESCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESCD>(arg0, 6, b"Escd", b"escord", b"Escort services refer to individuals or agencies that provide companionship for social, business, or personal events in exchange for a fee. This service is typically used for events such as dinners, business meetings, and special occasions, where individuals seek company.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_64ce739e20.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

