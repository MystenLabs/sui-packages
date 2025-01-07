module 0x358c028d6579cdc25084d5acc709943993c92d10dd5dcf2f9ae43d1660d0644a::sjjkhjkhkj {
    struct SJJKHJKHKJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJJKHJKHKJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJJKHJKHKJ>(arg0, 9, b"SJJKHJKHKJ", b"jhgjhg", b"jghkuhj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8717b140-f502-4284-bf73-d02d5599b3bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJJKHJKHKJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJJKHJKHKJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

