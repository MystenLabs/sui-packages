module 0x36ecc8ed73c98ff9d949acc36ca4777ff9975a89b6d5c3b0f85648edfdda6e3b::fgsd {
    struct FGSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGSD>(arg0, 9, b"FGSD", b"FDGH", b"SDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5794453-c38e-4a3d-b1ab-fb32642c6481.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

