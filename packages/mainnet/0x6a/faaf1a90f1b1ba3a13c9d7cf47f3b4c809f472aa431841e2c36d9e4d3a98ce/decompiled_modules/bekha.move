module 0x6afaaf1a90f1b1ba3a13c9d7cf47f3b4c809f472aa431841e2c36d9e4d3a98ce::bekha {
    struct BEKHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEKHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEKHA>(arg0, 9, b"BEKHA", x"d091d18dd185d0b0", x"d09cd0bed18f20d0bad0bed188d0bad0b020d0bfd0be20d0b8d0bcd0b5d0bdd0b8202d20d091d18dd185d0b02e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54af1126-0827-4202-a4d0-c4b3114f11b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEKHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEKHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

