module 0x5b986f47a24ed3bde0668e3b63af749e8c8e637834c42de9e68aa4a70d68e6de::dfwh {
    struct DFWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFWH>(arg0, 9, b"DFWH", b"DF Wif Hat", b"The frog wear dog wif frog hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f455853-b155-42c6-89f6-965a767b83cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

