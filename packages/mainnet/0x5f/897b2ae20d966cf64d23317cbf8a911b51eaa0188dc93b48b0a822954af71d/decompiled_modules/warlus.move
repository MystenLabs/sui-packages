module 0x5f897b2ae20d966cf64d23317cbf8a911b51eaa0188dc93b48b0a822954af71d::warlus {
    struct WARLUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARLUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARLUS>(arg0, 6, b"WARLUS", b"Warlus Protocol", b"Welcome to the next generation of data storage. Secure, efficient, and decentralized.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Cnn_5_Kz_C_400x400_4896a0d76b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARLUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARLUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

