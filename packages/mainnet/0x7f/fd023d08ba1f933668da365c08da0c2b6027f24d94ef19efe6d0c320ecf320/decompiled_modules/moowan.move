module 0x7ffd023d08ba1f933668da365c08da0c2b6027f24d94ef19efe6d0c320ecf320::moowan {
    struct MOOWAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOWAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOWAN>(arg0, 6, b"MooWan", b"Moo Wan_SUI", b"Meet Moo Wan, Moo Dengs big sis aka Sweet Pork. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_Ix_Gw_I8_Y_400x400_a69beceabb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOWAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOWAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

