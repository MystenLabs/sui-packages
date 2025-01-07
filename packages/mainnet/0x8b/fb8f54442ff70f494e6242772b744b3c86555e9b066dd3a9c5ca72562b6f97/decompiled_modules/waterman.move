module 0x8bfb8f54442ff70f494e6242772b744b3c86555e9b066dd3a9c5ca72562b6f97::waterman {
    struct WATERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERMAN>(arg0, 6, b"WATERMAN", b"BLUE WATERMAN", b"WATERMAN IS SUPERHERO ON SUI OCEAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/984_D2467_5_B1_F_41_E5_9_A48_B86_C6_DCF_016_C_9d9a42277e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

