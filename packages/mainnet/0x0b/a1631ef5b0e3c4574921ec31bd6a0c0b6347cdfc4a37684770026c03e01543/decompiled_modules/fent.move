module 0xba1631ef5b0e3c4574921ec31bd6a0c0b6347cdfc4a37684770026c03e01543::fent {
    struct FENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENT>(arg0, 6, b"FENT", b"George Droyd AI", b"Pure f***ing chaos fueling George Droyd AI. This isn't your grandmas token $FENT pumps hard, wrecks harder, and leaves no Narcan for the weak. You're either in or you're f***ed. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2273_064b6d4d33.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

