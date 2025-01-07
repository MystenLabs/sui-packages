module 0x2ca3dd826b9b791b16a28cb899590b46ec8867e867f02d205b4ecf5a9e672baf::elglobal {
    struct ELGLOBAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELGLOBAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELGLOBAL>(arg0, 9, b"ELGLOBAL", b"Elitglobal", b"Elite global adalah token yang bikin hodler auto JP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4c38924-a31f-4965-98bf-cb06ed27e7db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELGLOBAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELGLOBAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

