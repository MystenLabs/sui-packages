module 0x6261e6871532497440adf4a0abe7f77f9d7a53837adb53fb44743e60919ec97d::pm {
    struct PM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PM>(arg0, 6, b"PM", b"Pump Misery", b"Pump Misery is going to be a user-friendly memecoin generator that operates on the SUI blockchain. Pump Misery enables anyone to create and distribute their own tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_6b0da712a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PM>>(v1);
    }

    // decompiled from Move bytecode v6
}

