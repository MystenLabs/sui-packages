module 0x75e1fc09f6a3d9e92ee7510f38b370a948950062a044b6f0fb597e869731059e::rosie {
    struct ROSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSIE>(arg0, 6, b"Rosie", b"Rosie the Robot", b"Powered by AI, dedicated to moms, $ROSIE got your back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061121_4c08cf342b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

