module 0x99de881e63d61594c3b715eeb0b6bf89e3371e21924750b07a5238eb10cce2cf::falls {
    struct FALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALLS>(arg0, 6, b"FALLS", b"Viagra Falls", b"Legend has it, once upon a time, Earth swallowed a magical Viagra pill, and the mighty Niagara Falls was born, flowing endlessly since.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FALLS_T_Djw_Y5_qa9u_TMG_Fe9_Er_6f5335566f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

