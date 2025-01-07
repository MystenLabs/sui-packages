module 0x2167f9b01608572c33edc5f65e9981ff97d0c108c73bff4b1680e9d948b1f062::sls {
    struct SLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLS>(arg0, 9, b"SLS", b"Salasar ", b"Devotional Temple Charitable Trust ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a95c2ea7-93ac-48ab-95ba-fe04991bc4ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

