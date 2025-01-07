module 0x7ecc620b94d57990247f31cf12b7e2debb5b0a5fd99a902562ebe2e0a09cef0c::cbol {
    struct CBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBOL>(arg0, 6, b"CBOL", b"CAT ON BOWL", b"JUST CAT ON BOWL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/swwswswsw_64782f403d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

