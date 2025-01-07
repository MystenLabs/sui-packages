module 0x8abf644aad3b737ac5d868809c2f5cf2eff3a0dcc639d9305fa74b470f2af179::dork {
    struct DORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORK>(arg0, 6, b"DORK", b"DorkLord", x"4a6f696e20746865204d656d6520466f726365207769746820446f726b6c6f72643a2054686520426c6f636b636861696e204177616b656e73210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/2q_VGAI_Tu_400x400_c51e8e4459.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

