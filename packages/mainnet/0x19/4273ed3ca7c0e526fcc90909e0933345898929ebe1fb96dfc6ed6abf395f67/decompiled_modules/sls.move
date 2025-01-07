module 0x194273ed3ca7c0e526fcc90909e0933345898929ebe1fb96dfc6ed6abf395f67::sls {
    struct SLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLS>(arg0, 9, b"SLS", b"Salasar ", b"Devotional Temple Charitable Trust ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8440fb83-b5d1-40ea-b222-ce6c3e1bd4e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

