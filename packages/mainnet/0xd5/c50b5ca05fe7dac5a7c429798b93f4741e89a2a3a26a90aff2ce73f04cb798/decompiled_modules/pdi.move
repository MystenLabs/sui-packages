module 0xd5c50b5ca05fe7dac5a7c429798b93f4741e89a2a3a26a90aff2ce73f04cb798::pdi {
    struct PDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDI>(arg0, 9, b"PDI", b"DEMORASI", b"PDI (Participation, Decentralization, Inclusivity) is a meme coin celebrating freedom, participation, and openness in the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5d6ca87-df2b-4bf6-803e-eae8819e4369.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

