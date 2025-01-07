module 0xb4d2889ec8f6158c461cde7ed1f29426c1439a9c670590729d6d0879050aec3c::suidegen {
    struct SUIDEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEGEN>(arg0, 6, b"SUIDEGEN", b"Sui of degen", b"To be rich or poor, do degen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052721_392963d037.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

