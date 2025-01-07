module 0xe6f3faa4a7d8a51ad540ec688189061836ca3f842c71c71f951e62cc4255e538::retarded {
    struct RETARDED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDED>(arg0, 6, b"RETARDED", b"retarded kitty", b"IM RETARDED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/713o_Rm17_Z8_L_5c3768a6cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDED>>(v1);
    }

    // decompiled from Move bytecode v6
}

