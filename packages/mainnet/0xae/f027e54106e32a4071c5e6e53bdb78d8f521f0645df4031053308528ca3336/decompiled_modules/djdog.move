module 0xaef027e54106e32a4071c5e6e53bdb78d8f521f0645df4031053308528ca3336::djdog {
    struct DJDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJDOG>(arg0, 6, b"DJDOG", b"DJDOG SUI", b"DJDOG on SUI. Web3 Alpha Community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9507_3893c2215c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

