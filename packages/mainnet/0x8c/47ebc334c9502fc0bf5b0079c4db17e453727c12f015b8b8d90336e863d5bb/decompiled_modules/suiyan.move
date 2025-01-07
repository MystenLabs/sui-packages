module 0x8c47ebc334c9502fc0bf5b0079c4db17e453727c12f015b8b8d90336e863d5bb::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYAN>(arg0, 6, b"SUIYAN", b"Suiyan", b"$SUIYAN is a powerful and dynamic token on the SUI network, designed to embody the strength and spirit of the legendary Saiyans! Inspired by their relentless pursuit of greatness, $SUIYAN is more than just a currency; its a movement that empowers its community to reach new heights in the world of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/15_a60c2706df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

