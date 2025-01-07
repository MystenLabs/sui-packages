module 0xc92a79822d47056000b2030ed968ae93e9186a6d80103f3b1638952c3bd39292::stick {
    struct STICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STICK>(arg0, 6, b"STICK", b"STICK SUI", b"Cute Sticker sui maked by me !! PUMP IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3e314d6ea624f845925cb30271b71fbb_98038c9311.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

