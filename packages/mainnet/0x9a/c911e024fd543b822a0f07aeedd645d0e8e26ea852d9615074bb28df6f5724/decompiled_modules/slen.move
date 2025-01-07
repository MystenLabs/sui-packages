module 0x9ac911e024fd543b822a0f07aeedd645d0e8e26ea852d9615074bb28df6f5724::slen {
    struct SLEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEN>(arg0, 9, b"SLEN", b"SuitosiLEN", b" SuiToshi Revealed On SUI - Lets SUITosh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bea5bd46-ebdb-4374-be72-ebc4fd80f1bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

