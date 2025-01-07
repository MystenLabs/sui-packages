module 0x5589694f7450ae3e74e907f32de6320efe70521ab5cf1d087f0c7672e4723eee::tokenc {
    struct TOKENC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENC>(arg0, 6, b"TOKENC", b"TOKENC by SuiAI", b"TOKENC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Doge_shiba_full_smiling_7b72d4327e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

