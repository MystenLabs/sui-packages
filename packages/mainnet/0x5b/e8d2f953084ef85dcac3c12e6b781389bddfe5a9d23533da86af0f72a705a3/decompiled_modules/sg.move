module 0x5be8d2f953084ef85dcac3c12e6b781389bddfe5a9d23533da86af0f72a705a3::sg {
    struct SG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SG>(arg0, 6, b"SG", b"SUIGROW", b"Suigrow rides the SUI wave as Uptober approaches, fueling a massive pump to new highs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_9311981f58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SG>>(v1);
    }

    // decompiled from Move bytecode v6
}

