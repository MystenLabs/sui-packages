module 0x314ac1a9d66ed0d3411e0263bf4d0187bf08d50cb3b529b13b4a188b46c3e017::suig {
    struct SUIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG>(arg0, 6, b"Suig", b"Suigfried", b"They call me $Suig. Your best blue friend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tokenomics_man_6df634c0ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

