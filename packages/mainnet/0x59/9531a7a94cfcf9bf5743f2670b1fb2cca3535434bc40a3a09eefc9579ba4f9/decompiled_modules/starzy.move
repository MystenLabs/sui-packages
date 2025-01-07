module 0x599531a7a94cfcf9bf5743f2670b1fb2cca3535434bc40a3a09eefc9579ba4f9::starzy {
    struct STARZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARZY>(arg0, 6, b"STARZY", b"Starzy", b"Hey, it's the new rising star of SUI, hands up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/starzy_b73aed839f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

