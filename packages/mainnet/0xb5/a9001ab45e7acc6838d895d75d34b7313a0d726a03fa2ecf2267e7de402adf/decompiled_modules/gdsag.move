module 0xb5a9001ab45e7acc6838d895d75d34b7313a0d726a03fa2ecf2267e7de402adf::gdsag {
    struct GDSAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSAG>(arg0, 9, b"GDSAG", b"DAG", b"SAF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32b6e974-95f8-4c8a-aa7d-9f64741175af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

