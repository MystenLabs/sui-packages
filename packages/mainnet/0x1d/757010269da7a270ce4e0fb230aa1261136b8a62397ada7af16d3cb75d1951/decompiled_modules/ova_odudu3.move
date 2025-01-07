module 0x1d757010269da7a270ce4e0fb230aa1261136b8a62397ada7af16d3cb75d1951::ova_odudu3 {
    struct OVA_ODUDU3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVA_ODUDU3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVA_ODUDU3>(arg0, 9, b"OVA_ODUDU3", b"Oba", b"African cultural heritage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48e143c5-816a-4a48-a90f-25e304e84609.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVA_ODUDU3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OVA_ODUDU3>>(v1);
    }

    // decompiled from Move bytecode v6
}

