module 0x7d089e8d796bc95767cb4dba9166405e59bcbffa4590bd23519ee59ecc29ce5::broke {
    struct BROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKE>(arg0, 6, b"BROKE", b"Broke Sui", b"This is why we can't trust them, they are getting us $BROKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/broke_74510aea27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

