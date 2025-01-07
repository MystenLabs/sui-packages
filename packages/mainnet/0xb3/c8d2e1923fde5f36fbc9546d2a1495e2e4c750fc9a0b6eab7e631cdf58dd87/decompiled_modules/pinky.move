module 0xb3c8d2e1923fde5f36fbc9546d2a1495e2e4c750fc9a0b6eab7e631cdf58dd87::pinky {
    struct PINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKY>(arg0, 6, b"Pinky", b"Pinky the Pineapple", b" $PINKY the happy pineapple on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_12_12_42_86bd59598a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

