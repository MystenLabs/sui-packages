module 0x60e1f6c4c30270d582aa470c7709dee5e99343a4bd24bc238e83af5533a76321::desa {
    struct DESA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESA>(arg0, 9, b"DESA", b"Desadeee", b"marquisdesade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25484a32-ff75-4be3-89ba-34499f24a53b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DESA>>(v1);
    }

    // decompiled from Move bytecode v6
}

