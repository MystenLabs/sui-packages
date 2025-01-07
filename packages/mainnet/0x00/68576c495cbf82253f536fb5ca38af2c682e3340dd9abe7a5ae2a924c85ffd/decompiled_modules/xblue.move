module 0x68576c495cbf82253f536fb5ca38af2c682e3340dd9abe7a5ae2a924c85ffd::xblue {
    struct XBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBLUE>(arg0, 6, b"XBLUE", b"XBlue", b"Verified Badge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_12_af481c3e4e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

