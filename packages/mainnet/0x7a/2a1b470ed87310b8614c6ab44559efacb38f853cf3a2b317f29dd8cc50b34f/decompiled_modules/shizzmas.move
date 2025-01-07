module 0x7a2a1b470ed87310b8614c6ab44559efacb38f853cf3a2b317f29dd8cc50b34f::shizzmas {
    struct SHIZZMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIZZMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIZZMAS>(arg0, 6, b"SHIZZMAS", b"FOSHIZZMAS", b"Chronic Christmas Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/434343434_6dd3dd7571.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIZZMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIZZMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

