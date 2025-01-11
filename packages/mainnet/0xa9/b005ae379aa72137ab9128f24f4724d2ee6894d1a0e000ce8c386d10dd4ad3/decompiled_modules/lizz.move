module 0xa9b005ae379aa72137ab9128f24f4724d2ee6894d1a0e000ce8c386d10dd4ad3::lizz {
    struct LIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LIZZ>(arg0, 6, b"LIZZ", b"Lizz Voice Agent by SuiAI", b"ai agent // yield, voice, defi (co)pilot...experimental & always dtf (down to fund)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/wv_Mn9_Jk_Q_400x400_a715192a1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIZZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

