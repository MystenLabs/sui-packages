module 0xb70ef9bb0b12b0b92ee701f007879d46480e4fce09c83b5b30e20b13c2c89983::sofas {
    struct SOFAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFAS>(arg0, 9, b"SOFAS", b"SOFA ", b"Sofas market in lounch and boooooom it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18b76928-da79-4d53-b7bb-4bed53f8db55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOFAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

