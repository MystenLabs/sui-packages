module 0x7ebf1163691bf674f08cf20b13fe21fa62fc321f771f7a49a6af27c9e638ec19::dna {
    struct DNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNA>(arg0, 9, b"DNA", b"DNAGREEN", b"Evolve your crypto journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c25b3bb-206a-4f94-ac1b-c2629425ae2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

