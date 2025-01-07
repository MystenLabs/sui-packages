module 0x9219a3691d3a2041faa320beff5c408311b80badd9930c5f8f9b9d9b084b5bce::ponka {
    struct PONKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKA>(arg0, 6, b"PONKA", b"Ponka on SUI", x"506f6e6b61206f6e205355492077617665210a4c61756e6368696e67206e6f77206f6e204d6f766550756d7021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_ZH_Zj_AMW_400x400_e691f04f2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

