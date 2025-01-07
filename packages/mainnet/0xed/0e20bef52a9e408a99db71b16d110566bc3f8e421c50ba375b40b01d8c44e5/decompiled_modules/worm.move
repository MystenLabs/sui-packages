module 0xed0e20bef52a9e408a99db71b16d110566bc3f8e421c50ba375b40b01d8c44e5::worm {
    struct WORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORM>(arg0, 6, b"WORM", b"WORM SUI", b"$WORMS is inspired by the video game Worms, $WORMS has a mission to protect the environment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ca710634f81b2f209915540e4df1497b_d0739114ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORM>>(v1);
    }

    // decompiled from Move bytecode v6
}

