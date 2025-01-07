module 0x2779e2d03d43156d7f74df6723388959e87758898eeb01d8a872d3753ba263f4::doomer {
    struct DOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOMER>(arg0, 6, b"DOOMER", b"doomer", b"im 30y, playing skyrim rn, send this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/14_E_vx_A_400x400_7b41b885df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

