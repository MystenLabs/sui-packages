module 0x75133f53d48789bf7af651b3a941a1d773251188512fe682f19116370840197::sadco {
    struct SADCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADCO>(arg0, 9, b"SADCO", b"SadSad", b"For sad man ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4827cecf-23d7-412c-bb97-624aa1ca5319.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

