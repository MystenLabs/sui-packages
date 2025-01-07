module 0xfe1be274034852e9a107ae513685a3d2e33ea1e89948e4543c6b427e268f899c::sbuddha {
    struct SBUDDHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUDDHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUDDHA>(arg0, 6, b"SBuddha", b"Buddha", b"Welcome to Datang Ever-bright City in Dongtu.Welcome to the Sleepless City of the Great Tang Dynasty in the East. This is Cyber Buddha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012741_322a769cb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUDDHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBUDDHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

