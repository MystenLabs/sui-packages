module 0x47904abcc7a5a1422e53e8e081443c87bc7f7ee4a3c9026dc89fec4c2ff65f24::hebe {
    struct HEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEBE>(arg0, 9, b"HEBE", b"Suigar", b"Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5a6cc33-ddac-4643-9e54-7d2bc6773c6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

