module 0x5221df71890becbd5923ab26ef49621aef056820a9d77ee73a31ee6e0afcff0f::btcm {
    struct BTCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCM>(arg0, 9, b"BTCM", b"MDF", b"wave wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1569262f-856c-415b-b85d-285b4566b0da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

