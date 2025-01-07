module 0xb4783818bdbf515f302a8df9982c37137698e44cfafff8978d215d6b25c76a5f::peridol {
    struct PERIDOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERIDOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERIDOL>(arg0, 9, b"PERIDOL", b"SuiperIDOL", b"105C smiles ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51eba508-efce-40f1-b44a-84476989295d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERIDOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PERIDOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

