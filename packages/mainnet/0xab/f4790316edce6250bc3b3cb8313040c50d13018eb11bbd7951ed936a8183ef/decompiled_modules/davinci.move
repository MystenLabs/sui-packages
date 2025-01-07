module 0xabf4790316edce6250bc3b3cb8313040c50d13018eb11bbd7951ed936a8183ef::davinci {
    struct DAVINCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVINCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVINCI>(arg0, 9, b"DAVINCI", b"monalisa", b"Davinci fgo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f962f78c-0988-446f-b93b-01925525ec3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVINCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAVINCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

