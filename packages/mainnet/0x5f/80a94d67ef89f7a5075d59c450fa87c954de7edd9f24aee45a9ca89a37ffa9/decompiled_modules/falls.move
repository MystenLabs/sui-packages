module 0x5f80a94d67ef89f7a5075d59c450fa87c954de7edd9f24aee45a9ca89a37ffa9::falls {
    struct FALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALLS>(arg0, 6, b"FALLS", b"Viagra Falls", b"Legend has it, once upon a time, Earth swallowed a magical Viagra pill, and the mighty Niagara Falls was born, flowing endlessly since", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FALLS_T_Djw_Y5_qa9u_TMG_Fe9_Er_957ab0fe3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

