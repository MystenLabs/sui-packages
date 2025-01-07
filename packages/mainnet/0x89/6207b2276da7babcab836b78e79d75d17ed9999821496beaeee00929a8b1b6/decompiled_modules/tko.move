module 0x896207b2276da7babcab836b78e79d75d17ed9999821496beaeee00929a8b1b6::tko {
    struct TKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKO>(arg0, 9, b"TKO", b"TAKIO", b"From community to community to build income", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05fdeeb8-d423-44ac-bb10-4cda394899d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

