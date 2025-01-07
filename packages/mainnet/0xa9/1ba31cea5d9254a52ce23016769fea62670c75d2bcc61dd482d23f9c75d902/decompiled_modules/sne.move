module 0xa91ba31cea5d9254a52ce23016769fea62670c75d2bcc61dd482d23f9c75d902::sne {
    struct SNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNE>(arg0, 9, b"SNE", b"Outhouse ", b"Job description and a good ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94099326-f878-4ec6-990d-b2e0a9ededa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

