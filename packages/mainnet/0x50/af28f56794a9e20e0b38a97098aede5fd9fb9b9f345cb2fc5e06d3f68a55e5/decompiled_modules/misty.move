module 0x50af28f56794a9e20e0b38a97098aede5fd9fb9b9f345cb2fc5e06d3f68a55e5::misty {
    struct MISTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTY>(arg0, 6, b"MISTY", b"Misty Sui", b"$MISTY is introducing a new and exciting element to the $SUI ecosystem, enhancing its value and appeal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035607_52a1b9b0bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

