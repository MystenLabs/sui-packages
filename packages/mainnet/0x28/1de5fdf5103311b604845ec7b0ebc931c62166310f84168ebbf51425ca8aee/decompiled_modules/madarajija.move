module 0x281de5fdf5103311b604845ec7b0ebc931c62166310f84168ebbf51425ca8aee::madarajija {
    struct MADARAJIJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADARAJIJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADARAJIJA>(arg0, 9, b"MADARAJIJA", b"madarajija", b"me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f4c67ba-7762-49df-bc26-f09604a50e97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADARAJIJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MADARAJIJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

