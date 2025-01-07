module 0x7ee9dbb3ee078c06ba2b38e7a6ed5ec2531cd116dfe1e09b025c79b0c1b5da19::blumaja {
    struct BLUMAJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUMAJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUMAJA>(arg0, 9, b"BLUMAJA", b"BLUM", b"Blumje", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a4589bf-2c1d-43a9-8a0e-ee733c1602d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUMAJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUMAJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

