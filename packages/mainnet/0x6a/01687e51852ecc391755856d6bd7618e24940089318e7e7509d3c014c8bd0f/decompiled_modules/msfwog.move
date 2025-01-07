module 0x6a01687e51852ecc391755856d6bd7618e24940089318e7e7509d3c014c8bd0f::msfwog {
    struct MSFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSFWOG>(arg0, 6, b"MSFWOG", b"FWOG LOVE SUI", x"426568696e64207468652062656c6f7665642046776f67206973204d7346776f676869732068656172742c2068697320737061726b2c206869732065766572797468696e672e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/03_ba83ccdcc0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

