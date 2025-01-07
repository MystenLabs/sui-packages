module 0x497d9f7b2e2a1ff1cf8bb806d105d93ece3fd0eebf1a5739226d28814968f855::suilo {
    struct SUILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILO>(arg0, 6, b"SUILO", b"Suilo", b"teh must wetarded cet on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/richi_768x706_fef7cef323.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

