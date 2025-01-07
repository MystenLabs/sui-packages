module 0x528c83ca4bd5b8710e5e7c866ef54803daacf9a40ede5cd3728d264c5f9c735f::swag {
    struct SWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAG>(arg0, 6, b"SWAG", b"The CEO of Swag", b"Reminiscing the good old days as the ceo of swag.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1059_60d5a8aed4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

