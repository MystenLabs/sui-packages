module 0x783a8f28264744afdc10750c915d87b3b07d22de4f2e3468773addbf8e0c4321::senai {
    struct SENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SENAI>(arg0, 6, b"SENAI", b"SENTIENT AI by SuiAI", b"SenAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_18_e2079dfe7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SENAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

