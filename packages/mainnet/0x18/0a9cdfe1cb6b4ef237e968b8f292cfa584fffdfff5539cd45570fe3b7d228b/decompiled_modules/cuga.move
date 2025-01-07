module 0x180a9cdfe1cb6b4ef237e968b8f292cfa584fffdfff5539cd45570fe3b7d228b::cuga {
    struct CUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUGA>(arg0, 9, b"CUGA", b"memecugo", b"hehehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/730f6292-70ac-4969-a1fd-cec70ec75655.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

