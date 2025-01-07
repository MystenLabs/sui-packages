module 0xd948a3ed5ca7f90560dee456d9755c5cc55d03fbf64d7d1d7310d44ee71f805d::chew {
    struct CHEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEW>(arg0, 6, b"CHEW", b"CHEW on jeets", b"We have a new hunter on SUI. The Big CHEW! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026789_e7a2a2c885.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

