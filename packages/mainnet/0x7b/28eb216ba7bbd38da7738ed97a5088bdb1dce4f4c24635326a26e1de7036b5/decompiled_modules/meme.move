module 0x7b28eb216ba7bbd38da7738ed97a5088bdb1dce4f4c24635326a26e1de7036b5::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MEME>(arg0, 6, b"MEME", b"MEME INDUSTRY by SuiAI", b"For the initiated.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/69v_Qwfg_G_400x400_a4ae64d0b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

