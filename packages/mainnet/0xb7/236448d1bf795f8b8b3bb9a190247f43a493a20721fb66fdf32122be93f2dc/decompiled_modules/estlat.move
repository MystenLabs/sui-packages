module 0xb7236448d1bf795f8b8b3bb9a190247f43a493a20721fb66fdf32122be93f2dc::estlat {
    struct ESTLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTLAT>(arg0, 9, b"ESTLAT", b"EstlatCoin", b"First coin of Esther ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47a847ac-0e91-4c23-8a59-703cd8afaa5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTLAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESTLAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

