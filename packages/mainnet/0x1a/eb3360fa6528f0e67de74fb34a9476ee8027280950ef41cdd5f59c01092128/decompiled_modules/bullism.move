module 0x1aeb3360fa6528f0e67de74fb34a9476ee8027280950ef41cdd5f59c01092128::bullism {
    struct BULLISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLISM>(arg0, 6, b"BULLISM", b"bullism", b"In $BULLISM we charge FORWARD, we bet BIG, and embrace the CHAOS. No tolerance for paper hands, and non-believers. Just pure conviction and the will to push forward", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241128_090950_574_5b13c04e1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

