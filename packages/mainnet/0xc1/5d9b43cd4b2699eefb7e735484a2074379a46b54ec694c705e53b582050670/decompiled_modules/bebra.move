module 0xc15d9b43cd4b2699eefb7e735484a2074379a46b54ec694c705e53b582050670::bebra {
    struct BEBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBRA>(arg0, 9, b"BEBRA", b"bebra", b"Bebra Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/362e3424-8ca4-4801-9d6c-d27a49e5617c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

