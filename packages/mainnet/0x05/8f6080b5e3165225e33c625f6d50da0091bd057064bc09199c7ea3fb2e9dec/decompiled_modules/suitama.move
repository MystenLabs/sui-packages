module 0x58f6080b5e3165225e33c625f6d50da0091bd057064bc09199c7ea3fb2e9dec::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 6, b"SUITAMA", b"BLUE SUITAMA", b"ONE PUNCH MAN SAITAMA ANIME $SUITAMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3663_6c578d9227.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

