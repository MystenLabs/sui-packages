module 0x7ecfee26bc09808287c99f3fb55a871d7487444b5919d22c8ef9c8cd22a79dac::babysuidog {
    struct BABYSUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUIDOG>(arg0, 6, b"BABYSUIDOG", b"BABY SUI DOG", b"SUIDOG TEAM NEW TOKEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2d5738699530687fd02dbec7552ad56_b6efeb076d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

