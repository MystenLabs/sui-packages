module 0x39a8a2db8306b945270ba3977ac323a56f96b380e177c63f23f2bf3e12fc6b3e::pepeai {
    struct PEPEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEAI>(arg0, 6, b"PEPEAI", b"Pepe AI Agent on Sui", b"An advanced version of Pepe on Sui from the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_17_21_20_13_c60cc05666.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

