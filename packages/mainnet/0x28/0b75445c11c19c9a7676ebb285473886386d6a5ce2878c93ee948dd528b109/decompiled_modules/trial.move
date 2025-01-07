module 0x280b75445c11c19c9a7676ebb285473886386d6a5ce2878c93ee948dd528b109::trial {
    struct TRIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIAL>(arg0, 6, b"triAL", b"triAL and ErRor", b"triAL aNd eRrOr!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vyl6_A_HH_400x400_ed10d7e62c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

