module 0x5124e2329ab4d21e87744fa932973998557e583bb661be9012cb966aa575a2ea::llambo {
    struct LLAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMBO>(arg0, 9, b"LLAMBO", b"LlamaLambo", b"Move fast and llama-style. This token combines speed with quirky style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e157574-8061-44f2-8229-de7ec3fade00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

