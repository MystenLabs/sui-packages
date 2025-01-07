module 0xbd5959ae390ae7e4dca77faa90ce687dc954a34cabe32c2f99bef9c1cc6ce992::donald {
    struct DONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALD>(arg0, 9, b"DONALD", b"DDT", b"Dance Donald Trump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a21f4bb2-baa5-479e-910c-763f413e49c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

