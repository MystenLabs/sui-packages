module 0x6f7c62258c112d69111d0d42dc67da115222fc0c9f7efb03baacd86a1f90e31f::cristiano {
    struct CRISTIANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRISTIANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRISTIANO>(arg0, 9, b"CRISTIANO", b"CR7", b"SUI SUI RONALDO, MEME RONALDO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc8597d3-358d-403b-81b5-3e723f2c7909.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRISTIANO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRISTIANO>>(v1);
    }

    // decompiled from Move bytecode v6
}

