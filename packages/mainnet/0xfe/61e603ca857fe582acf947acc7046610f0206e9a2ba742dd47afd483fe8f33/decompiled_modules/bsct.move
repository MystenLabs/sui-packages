module 0xfe61e603ca857fe582acf947acc7046610f0206e9a2ba742dd47afd483fe8f33::bsct {
    struct BSCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSCT>(arg0, 6, b"BSCT", b"BabySimonsCat", b"One Baby Cat. Limitless Dreams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BABY_a8cf9b0430.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

