module 0x6c2b28068e3b7aa1394c723dd09b49128723778ae3933aa6a1451c8cfbb543::tuna {
    struct TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNA>(arg0, 6, b"TUNA", b"Tuna Turner", b"Ride the waves with the queen of the SUI ocean- Tuna Turner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9422_1b0a3d6418.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

