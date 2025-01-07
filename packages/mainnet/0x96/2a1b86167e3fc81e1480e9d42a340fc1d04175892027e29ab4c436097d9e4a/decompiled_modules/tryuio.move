module 0x962a1b86167e3fc81e1480e9d42a340fc1d04175892027e29ab4c436097d9e4a::tryuio {
    struct TRYUIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYUIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYUIO>(arg0, 9, b"TRYUIO", b"dfdf", b"sdfrwtrgd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/963834d0-c59b-4217-945c-02fd0285cde6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYUIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRYUIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

