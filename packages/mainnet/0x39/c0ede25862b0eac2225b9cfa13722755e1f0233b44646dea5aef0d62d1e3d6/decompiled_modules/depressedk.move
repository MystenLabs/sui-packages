module 0x39c0ede25862b0eac2225b9cfa13722755e1f0233b44646dea5aef0d62d1e3d6::depressedk {
    struct DEPRESSEDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPRESSEDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPRESSEDK>(arg0, 9, b"DEPRESSEDK", b"DKID", b"Depressed Kid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56e935b5-6402-4dc8-a052-72a6b9b7ab0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPRESSEDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPRESSEDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

