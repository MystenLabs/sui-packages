module 0x57660ef7b9b98103cb0fc19c2acf577ccccd1d9ba483bf3279bba9cff22855b3::cty {
    struct CTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTY>(arg0, 9, b"CTY", b"City token", b"Citydex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0909231-1c10-4e32-92b1-dbcd00f86c5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

