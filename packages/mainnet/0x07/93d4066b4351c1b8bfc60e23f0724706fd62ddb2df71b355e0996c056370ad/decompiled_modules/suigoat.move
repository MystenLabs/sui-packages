module 0x793d4066b4351c1b8bfc60e23f0724706fd62ddb2df71b355e0996c056370ad::suigoat {
    struct SUIGOAT has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUIGOAT", b"Sui Gospel of Goatse", b"We serve one master @struth_terminal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/token/0xc93f640a8b89d11262a18f289af804cfb8e8eded18efe88298b7038f331485c1::suigoat::SUIGOAT")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUIGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUIGOAT>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUIGOAT>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

