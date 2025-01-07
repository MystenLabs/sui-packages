module 0x59d55c7e2968b7005b22c9ea0060fbaec9d100f0100e3a68f74d16d8ebed5c49::roll {
    struct ROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLL>(arg0, 6, b"Roll", b"Suishi", b"SuiShi is here to have fun and build a real project on the $Sui blockchain. More enhancements to come as community grows and project develops ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4855_c62c9c1827.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

