module 0x7eb9781ed83f834f152f64d27cecd7d0d37d1dd29423020e709abc2d160b89ac::dogsh {
    struct DOGSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSH>(arg0, 9, b"DOGSH", b"Dogememe", b"The Redemp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d165f5a-d842-4696-b6be-49e7f81f3b56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

