module 0x732d5ed967f8ee82fdf71bc73f9dcc352cd16b270e96340533daa1391111a::josie {
    struct JOSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOSIE>(arg0, 9, b"Josie", b"Josephine", b"Crocheted a beanie for my friends cat with tiny beans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPMbR5KsvgbFRzg1n1QWM4THRhKykCkARLdPW45dSPMEo")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOSIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOSIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOSIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

