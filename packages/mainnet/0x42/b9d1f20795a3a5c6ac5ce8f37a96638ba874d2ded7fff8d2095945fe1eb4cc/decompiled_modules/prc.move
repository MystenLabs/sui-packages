module 0x42b9d1f20795a3a5c6ac5ce8f37a96638ba874d2ded7fff8d2095945fe1eb4cc::prc {
    struct PRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRC>(arg0, 9, b"PRC", b"PRINCAT", b"A funky cat prince exploring the cosmos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13ddbc7a-74e1-42d3-adfc-63b0d7379ae0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

