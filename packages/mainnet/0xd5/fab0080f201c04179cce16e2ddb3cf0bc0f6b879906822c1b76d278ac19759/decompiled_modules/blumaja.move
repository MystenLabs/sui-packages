module 0xd5fab0080f201c04179cce16e2ddb3cf0bc0f6b879906822c1b76d278ac19759::blumaja {
    struct BLUMAJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUMAJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUMAJA>(arg0, 9, b"BLUMAJA", b"BLUM", b"Blumje", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01ad3514-2c65-47ac-9895-f90a1c9a3181.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUMAJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUMAJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

