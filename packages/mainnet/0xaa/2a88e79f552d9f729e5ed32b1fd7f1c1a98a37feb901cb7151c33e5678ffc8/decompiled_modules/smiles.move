module 0xaa2a88e79f552d9f729e5ed32b1fd7f1c1a98a37feb901cb7151c33e5678ffc8::smiles {
    struct SMILES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILES>(arg0, 9, b"SMILES", b":)", b"SSMILES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58dbc604-6e98-4b53-8efd-9a5495b1084d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMILES>>(v1);
    }

    // decompiled from Move bytecode v6
}

