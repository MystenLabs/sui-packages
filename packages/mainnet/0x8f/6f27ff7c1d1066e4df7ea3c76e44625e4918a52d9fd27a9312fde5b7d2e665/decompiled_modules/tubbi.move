module 0x8f6f27ff7c1d1066e4df7ea3c76e44625e4918a52d9fd27a9312fde5b7d2e665::tubbi {
    struct TUBBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUBBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUBBI>(arg0, 6, b"TUBBI", b"Tubbi", b"The first playable Character on MemeArena.net inspired by Teletubbies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T_logo3_5c02478871.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUBBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUBBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

