module 0x2a0660987951f0d0cd0f78a8f6100f37499cad569c3da9465d7fb97e45d1faca::suidogg {
    struct SUIDOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGG>(arg0, 6, b"SuiDogg", b"Sui Dogg", b"Ladi da di! It's time to party! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020958_fb8521671c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

