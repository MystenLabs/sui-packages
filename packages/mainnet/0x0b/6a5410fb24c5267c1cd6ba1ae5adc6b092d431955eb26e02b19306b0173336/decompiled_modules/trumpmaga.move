module 0xb6a5410fb24c5267c1cd6ba1ae5adc6b092d431955eb26e02b19306b0173336::trumpmaga {
    struct TRUMPMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMAGA>(arg0, 9, b"TRUMPMAGA", b"TRUMP", b"Trump token for trumpers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f8b6704-1e9d-430f-8411-c3be8b765806.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

