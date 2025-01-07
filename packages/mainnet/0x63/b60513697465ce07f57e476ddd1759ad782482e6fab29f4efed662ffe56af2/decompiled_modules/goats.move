module 0x63b60513697465ce07f57e476ddd1759ad782482e6fab29f4efed662ffe56af2::goats {
    struct GOATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATS>(arg0, 6, b"GOATS", b"GOAT OF SUI", b"Real $GOATS never suileep!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goats_29c3a81efa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

