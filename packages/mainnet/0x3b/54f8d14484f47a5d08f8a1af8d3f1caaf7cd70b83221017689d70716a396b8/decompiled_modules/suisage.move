module 0x3b54f8d14484f47a5d08f8a1af8d3f1caaf7cd70b83221017689d70716a396b8::suisage {
    struct SUISAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAGE>(arg0, 6, b"Suisage", b"SUISAGE", b"Suasage- Suisage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/460365239_827613039224645_2178186372551022521_n_bff5babae6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

