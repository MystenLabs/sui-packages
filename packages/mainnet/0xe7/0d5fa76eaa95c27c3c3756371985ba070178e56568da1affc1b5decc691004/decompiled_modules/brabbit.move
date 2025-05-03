module 0xe70d5fa76eaa95c27c3c3756371985ba070178e56568da1affc1b5decc691004::brabbit {
    struct BRABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRABBIT>(arg0, 6, b"BRABBIT", b"BRAIN RABBIT", b"We are coming to turn this place into a carrot world with rabbit intelligence and power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_29_23_48_48_25d22efbbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRABBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRABBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

