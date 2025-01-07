module 0x713ff8dda2f2fa9f7754b7c1b6793221b44550fa3c4854d44c52e241dd5b1a82::phantom_type {
    struct PHANTOM_TYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANTOM_TYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHANTOM_TYPE>(arg0, 6, b"SYMBOL", b"BSCC", b"DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"url")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHANTOM_TYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHANTOM_TYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

