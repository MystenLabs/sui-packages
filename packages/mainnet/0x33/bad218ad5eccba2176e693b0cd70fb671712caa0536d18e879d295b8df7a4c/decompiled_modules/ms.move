module 0x33bad218ad5eccba2176e693b0cd70fb671712caa0536d18e879d295b8df7a4c::ms {
    struct MS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MS>(arg0, 6, b"MS", b"MOVESUI", b"Our beloved MOVE community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726146248612_a0ca52f873.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MS>>(v1);
    }

    // decompiled from Move bytecode v6
}

