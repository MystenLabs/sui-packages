module 0xe3cfeacbdc142f36f7dd4f8b2b45c00aaab917aec37ef218c30af83f053d8e51::mxpr {
    struct MXPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXPR>(arg0, 9, b"MXPR", b"MaxPro ", b"Maximum Professional Maximum Professional ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fde2f392-d49b-4da6-9753-7fa20d8f0c36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

