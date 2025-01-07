module 0x84383d9cdb65d1ae3a71e788eac6727424a7ecaf74ec85e176fc2a711157cc0d::fogy {
    struct FOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOGY>(arg0, 6, b"Fogy", b"FogyTheFrog", b"Meet Fogy, the SUI frog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FOGY_84edfb75f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

