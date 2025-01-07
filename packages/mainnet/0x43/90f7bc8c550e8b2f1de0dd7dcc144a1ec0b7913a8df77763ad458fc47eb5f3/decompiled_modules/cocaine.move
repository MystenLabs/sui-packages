module 0x4390f7bc8c550e8b2f1de0dd7dcc144a1ec0b7913a8df77763ad458fc47eb5f3::cocaine {
    struct COCAINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCAINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCAINE>(arg0, 6, b"COCAINE", b"Cocaine Horse", b"Just a depressed horse running around in this wild west of crypto, with his small pack of cocaine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_21_34_54_8abb7a0928.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCAINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCAINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

