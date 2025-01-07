module 0x49ff0420b3ab53b80bcfd005757334901dbcce01c149e7f0a70840b791cb01cb::dfz {
    struct DFZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFZ>(arg0, 9, b"DFZ", b"KJHSD", b"BBCC ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57731d26-49c7-424e-aeab-89d4e8fdbfda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

