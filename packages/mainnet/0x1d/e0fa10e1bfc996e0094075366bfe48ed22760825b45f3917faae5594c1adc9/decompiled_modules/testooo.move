module 0x1de0fa10e1bfc996e0094075366bfe48ed22760825b45f3917faae5594c1adc9::testooo {
    struct TESTOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTOOO>(arg0, 6, b"TESTOOO", b"testooo by SuiAI", b"testooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Copy_of_0xe3360ed65e5e6c1d584647d02333aead5942357502574654c266d83cf8c455a0towel_TOWEL_200_x_200_px_500_x_500_px_3b621bbf0d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTOOO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTOOO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

