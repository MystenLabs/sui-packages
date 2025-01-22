module 0xde5c8dc273ec242dc1c81f58ee5d6b6f19e4663fd99fa1cecf56ce4f5991748e::joebama {
    struct JOEBAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOEBAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOEBAMA>(arg0, 6, b"JOEBAMA", b"Barry JoeBama", b"Retired but living rent-free in Trump's head.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Unknown_12_9127fbee89.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOEBAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOEBAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

