module 0x521b7146ea0018121783741c0a97bd226f073054aab4304fce62e0a680ec28ab::suielgato {
    struct SUIELGATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIELGATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIELGATO>(arg0, 6, b"SUIELGATO", b"Suielgato", b"THE REAL ELGATO CAT ON SUI CHAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_cat_2bcf833413.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIELGATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIELGATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

