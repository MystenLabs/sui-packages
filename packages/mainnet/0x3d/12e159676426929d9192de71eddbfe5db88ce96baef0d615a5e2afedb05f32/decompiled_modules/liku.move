module 0x3d12e159676426929d9192de71eddbfe5db88ce96baef0d615a5e2afedb05f32::liku {
    struct LIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIKU>(arg0, 6, b"LIKU", b"Liku", b"A cursed panda with no family, you guessed it right, thats Liku.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_04_T132905_124_ec4f53c9bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

