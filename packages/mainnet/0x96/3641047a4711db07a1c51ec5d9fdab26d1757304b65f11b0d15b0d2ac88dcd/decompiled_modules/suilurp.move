module 0x963641047a4711db07a1c51ec5d9fdab26d1757304b65f11b0d15b0d2ac88dcd::suilurp {
    struct SUILURP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILURP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILURP>(arg0, 6, b"SUILURP", b"Suilurp", b"Suilurp is here to slurp every dip on Sui Network! Together let us build an awesome Suilurp community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5069_bf34ca3ecb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILURP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILURP>>(v1);
    }

    // decompiled from Move bytecode v6
}

