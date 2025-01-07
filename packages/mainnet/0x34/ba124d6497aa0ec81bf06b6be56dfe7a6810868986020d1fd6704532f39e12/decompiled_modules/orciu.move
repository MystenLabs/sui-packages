module 0x34ba124d6497aa0ec81bf06b6be56dfe7a6810868986020d1fd6704532f39e12::orciu {
    struct ORCIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCIU>(arg0, 6, b"ORCIU", b"Orca Sui", b"The apex predator of the Sui network, ready to dominate the Sui seas. Orca Sui is here to make waves, with the strength of a killer whale and the power of Sui behind it. Get on board or get left behind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_10_ee8ce1f77d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

