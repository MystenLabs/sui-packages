module 0x2cc3955f10df49a670e7a98afc86fe7d11f1cb2280ddf7868710e8830853de4b::testo {
    struct TESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTO>(arg0, 6, b"TESTO", b"testo by SuiAI", b"testoooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Copy_of_0xe3360ed65e5e6c1d584647d02333aead5942357502574654c266d83cf8c455a0towel_TOWEL_200_x_200_px_500_x_500_px_d386d0cea5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

