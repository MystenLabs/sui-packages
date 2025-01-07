module 0x50b8caed1f471e0820e6005bec0f322849c1d9b86a2580e6334c0bdb3fb4c657::sking {
    struct SKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKING>(arg0, 9, b"sking", b"SuiKing", b"Look in the eyes and you will see the reason you failed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/PNPm2ss")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKING>(&mut v2, 987654321000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

