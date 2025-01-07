module 0xe2be4fe48ec245c3303e7a23b3dfc5852ffeebd03c5237f416e22150ecac3d75::pasok {
    struct PASOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PASOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PASOK>(arg0, 6, b"PASOK", b"PASOK", b"PASOK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Satoshi_Papandreou_b3a70977ef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PASOK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PASOK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

