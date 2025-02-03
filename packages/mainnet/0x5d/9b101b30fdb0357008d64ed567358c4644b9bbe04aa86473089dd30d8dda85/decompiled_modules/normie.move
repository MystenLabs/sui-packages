module 0x5d9b101b30fdb0357008d64ed567358c4644b9bbe04aa86473089dd30d8dda85::normie {
    struct NORMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORMIE>(arg0, 6, b"NORMIE", b"Normie on SUI", b"Everyone starts as a NORMIE... Yes even you! Join the NORMIE movement ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6tvy_Q3x_K_400x400_2015f97ef5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORMIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORMIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

