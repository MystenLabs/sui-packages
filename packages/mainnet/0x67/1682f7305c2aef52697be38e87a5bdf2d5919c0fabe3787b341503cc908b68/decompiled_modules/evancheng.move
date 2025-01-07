module 0x671682f7305c2aef52697be38e87a5bdf2d5919c0fabe3787b341503cc908b68::evancheng {
    struct EVANCHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVANCHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVANCHENG>(arg0, 6, b"EvanCheng", b"Evan Cheng CEO SUI", x"436f2d666f756e64657220262043454f206f66204d797374656e204c616273202d206372656174696e6720666f756e646174696f6e616c207765623320696e667261200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CEOSUI_fotor_bg_remover_20240912105727_0ff57b33e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVANCHENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVANCHENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

