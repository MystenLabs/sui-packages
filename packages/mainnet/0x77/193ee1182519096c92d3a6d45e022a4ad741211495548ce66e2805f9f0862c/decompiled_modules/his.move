module 0x77193ee1182519096c92d3a6d45e022a4ad741211495548ce66e2805f9f0862c::his {
    struct HIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIS>(arg0, 6, b"HIS", b"HopIsShit", b"BUY AND PUSH THAT HOP FUN IS SHIT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopshit_3bbe8d55d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

