module 0x8ca66967d3929f2ef640406a5eec9a4ad3d90603c149bdbd4b7bac3c7535a046::pokko {
    struct POKKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKKO>(arg0, 9, b"POKKO", b"MamyPokko", b"The best Brand diapers in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee9a0c60-8174-417d-9177-927a6a1d4b35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

