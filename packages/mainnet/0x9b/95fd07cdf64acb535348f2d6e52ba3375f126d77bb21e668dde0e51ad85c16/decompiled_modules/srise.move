module 0x9b95fd07cdf64acb535348f2d6e52ba3375f126d77bb21e668dde0e51ad85c16::srise {
    struct SRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRISE>(arg0, 6, b"SRISE", b"SUIRISE", x"2453554920e2978f204149204167656e74205f2f20487970654167656e74206f6620245355492045636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736960361668.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRISE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRISE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

