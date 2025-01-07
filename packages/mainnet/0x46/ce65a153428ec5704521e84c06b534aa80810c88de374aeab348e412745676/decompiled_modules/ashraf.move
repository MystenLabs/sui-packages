module 0x46ce65a153428ec5704521e84c06b534aa80810c88de374aeab348e412745676::ashraf {
    struct ASHRAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHRAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHRAF>(arg0, 9, b"ASHRAF", b"Ramiz ", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d82d5f88-4ae1-4d50-8332-3f71bd9ae711.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHRAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASHRAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

