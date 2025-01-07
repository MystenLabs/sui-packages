module 0xcab8cf8785f1f35bedccc9a77eb5bc37a01b6130116707dfd4fa580c5960c8e9::pampi {
    struct PAMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMPI>(arg0, 9, b"PAMPI", b"Pampi", b"Inspried by Disney cartoon deer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a12dbf2-6007-496f-9cb1-e289916c9f78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

