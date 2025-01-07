module 0x9705d154c5c4dfb047732ea14171ba3d090ecf3f546828622ad108ca07bf6334::tcanguro {
    struct TCANGURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCANGURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCANGURO>(arg0, 6, b"TCANGURO", b"Team Canguro", b"Team canguro on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051436_6c8f7089b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCANGURO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCANGURO>>(v1);
    }

    // decompiled from Move bytecode v6
}

