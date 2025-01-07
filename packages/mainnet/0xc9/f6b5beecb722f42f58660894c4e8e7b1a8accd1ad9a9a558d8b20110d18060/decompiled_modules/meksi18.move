module 0xc9f6b5beecb722f42f58660894c4e8e7b1a8accd1ad9a9a558d8b20110d18060::meksi18 {
    struct MEKSI18 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEKSI18, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKSI18>(arg0, 9, b"MEKSI18", b"Meks", b"Riches ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40a83727-e656-4ebc-ad55-d2f86aad69dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKSI18>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEKSI18>>(v1);
    }

    // decompiled from Move bytecode v6
}

