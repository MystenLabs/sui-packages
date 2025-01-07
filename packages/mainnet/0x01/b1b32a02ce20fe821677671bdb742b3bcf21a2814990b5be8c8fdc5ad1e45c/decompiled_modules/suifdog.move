module 0x1b1b32a02ce20fe821677671bdb742b3bcf21a2814990b5be8c8fdc5ad1e45c::suifdog {
    struct SUIFDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFDOG>(arg0, 9, b"SUIFDOG", b"Suif", b"Sui and wif", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32e4f75f-5a2c-4896-8461-2956bfe54c8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

