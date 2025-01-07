module 0x59abc60a60e99f74e8c317962a8f007002aa7e267a4085bb88f882dcb0294bd8::plup {
    struct PLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUP>(arg0, 6, b"PLUP", b"SuiPlup", b"The most cutest water pokemon is now on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PLUP_9ab4f4dc3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

