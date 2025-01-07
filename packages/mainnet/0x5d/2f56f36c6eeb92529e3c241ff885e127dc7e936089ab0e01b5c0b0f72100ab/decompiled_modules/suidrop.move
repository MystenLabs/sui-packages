module 0x5d2f56f36c6eeb92529e3c241ff885e127dc7e936089ab0e01b5c0b0f72100ab::suidrop {
    struct SUIDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDROP>(arg0, 6, b"SuiDrop", b"suiDrop", b"lucydrop? Nah Sui Drop ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Ich_6p_M_400x400_b0bfe9f17e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

