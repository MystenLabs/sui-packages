module 0xc258b4de52525b166ca1b2ca98364b32982b43042881c84209feb93a8cf42bd1::thira {
    struct THIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THIRA>(arg0, 9, b"THIRA", b"Thiramaala", b"Ocean waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2db736d5-7b1e-4c7f-9291-4638ff6f1a17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

