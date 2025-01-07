module 0x716308fd293fa6c4552bcdeb359b21aaa182dcb3f216a382246f8bd0d227732::suibit {
    struct SUIBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIT>(arg0, 6, b"SUIBIT", b"The suibit", b"Meet SUIBIT, a memecoin with the best ticker you'll ever see on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053668_db2385e9dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

