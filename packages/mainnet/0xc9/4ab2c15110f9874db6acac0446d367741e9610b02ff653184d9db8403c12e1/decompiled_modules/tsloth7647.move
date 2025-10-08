module 0xc94ab2c15110f9874db6acac0446d367741e9610b02ff653184d9db8403c12e1::tsloth7647 {
    struct TSLOTH7647 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSLOTH7647, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSLOTH7647>(arg0, 8, b"TSLOTH7647", b"Turbo Sloth #7647", b"Slow and steady wins the race", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/turbo-sloth.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSLOTH7647>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSLOTH7647>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

