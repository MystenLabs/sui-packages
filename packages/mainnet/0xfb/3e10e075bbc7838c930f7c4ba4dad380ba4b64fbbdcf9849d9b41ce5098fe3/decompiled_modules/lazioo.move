module 0xfb3e10e075bbc7838c930f7c4ba4dad380ba4b64fbbdcf9849d9b41ce5098fe3::lazioo {
    struct LAZIOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAZIOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZIOO>(arg0, 9, b"LAZIOO", b"Lazio", b"Lazioooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d18eef54-0817-46d2-9bae-1f6346fade2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZIOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAZIOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

