module 0x4d65a8f9dfbe282366e003d014d07cd4cf91f1b4d014691cfd49d665c2e9fbd3::salutetoace {
    struct SALUTETOACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALUTETOACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALUTETOACE>(arg0, 6, b"SalutetoAce", b"Ais", b"Tribute to Fire Fist Ace, let's send him on.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012748_90ab3e06e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALUTETOACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALUTETOACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

