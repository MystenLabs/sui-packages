module 0x9319a6462d2b538ab69ac97efe3b1c250563f75a04c912a9a3cdef1df76971a9::gtasa {
    struct GTASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTASA>(arg0, 6, b"GTASA", b"SUI ANDREAS", b"Ah shit, here we go again...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_51_b019abd618.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

