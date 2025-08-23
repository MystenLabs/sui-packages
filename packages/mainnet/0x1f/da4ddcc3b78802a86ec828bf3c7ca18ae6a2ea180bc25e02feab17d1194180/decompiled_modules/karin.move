module 0x1fda4ddcc3b78802a86ec828bf3c7ca18ae6a2ea180bc25e02feab17d1194180::karin {
    struct KARIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARIN>(arg0, 9, b"Karin", b"Maha", b"Kejt ma hani karin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KARIN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARIN>>(v2, @0xf16666d0ec949f88bc113eca7575f8d7171574600b6f3b635a41dcb06d182ff8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KARIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

