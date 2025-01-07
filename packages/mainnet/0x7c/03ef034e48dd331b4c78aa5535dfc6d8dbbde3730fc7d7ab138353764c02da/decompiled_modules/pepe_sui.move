module 0x7c03ef034e48dd331b4c78aa5535dfc6d8dbbde3730fc7d7ab138353764c02da::pepe_sui {
    struct PEPE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE_SUI>(arg0, 9, b"PEPE_SUI", b"Weww_pepe", b"Wewe Pepe minted on the Sui Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03db298b-f171-4885-9ad6-6c067ee2f3e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

