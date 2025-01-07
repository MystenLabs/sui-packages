module 0x27ee836ad5e26b6c74a61a5eaf167e8942fc27f2e219c5bdc1561ccd55881bf1::dkdkkd {
    struct DKDKKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKDKKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKDKKD>(arg0, 9, b"DKDKKD", b"Syakwk", b"Cllvlcj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/afd9bf9b-04cb-4e70-baca-2aca380b29f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKDKKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKDKKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

