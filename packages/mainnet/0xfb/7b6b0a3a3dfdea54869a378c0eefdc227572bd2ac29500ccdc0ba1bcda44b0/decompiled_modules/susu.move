module 0xfb7b6b0a3a3dfdea54869a378c0eefdc227572bd2ac29500ccdc0ba1bcda44b0::susu {
    struct SUSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSU>(arg0, 6, b"SUSU", b"SUSU ON SUI", b"Meet $SUSU, the lazy green monster that doesnt give a damn about anything or anyone. $SUSU is sick of watching meme tokens recently bleed to zero and be left with a true $SUSU moment. He decided to launch his own memetoken $SUSU. Powered by the legendary Mike Wazowski $SUSU face, our mission is simple. Spread the $SUSU energy far and wide. Let's make every $SUSU moment count. Susu. Susu. Susu. Susu. Susu. Susu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bfe_038091796d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

