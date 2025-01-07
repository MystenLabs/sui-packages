module 0x3910ffd97bb58242122b79a99caf2b74a3f9da3d0aeacd0865aea6adc531a8e3::slen {
    struct SLEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEN>(arg0, 9, b"SLEN", b"SuitosiLEN", b" SuiToshi Revealed On SUI - Lets SUITosh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4380a6fa-2e90-4ebe-aab5-0e68e7101bf9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

