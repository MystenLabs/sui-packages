module 0xca346ca053a8dfc85fcdc2416a488248d4642c344bbd69e11d7f3a5016fa5d6d::ova_odudu3 {
    struct OVA_ODUDU3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVA_ODUDU3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVA_ODUDU3>(arg0, 9, b"OVA_ODUDU3", b"Oba", b"African cultural heritage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42ef9088-e5fe-4f3a-896c-5f43a945922a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVA_ODUDU3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OVA_ODUDU3>>(v1);
    }

    // decompiled from Move bytecode v6
}

