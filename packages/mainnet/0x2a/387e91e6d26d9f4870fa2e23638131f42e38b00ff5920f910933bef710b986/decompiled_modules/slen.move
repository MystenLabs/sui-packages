module 0x2a387e91e6d26d9f4870fa2e23638131f42e38b00ff5920f910933bef710b986::slen {
    struct SLEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEN>(arg0, 9, b"SLEN", b"SuitosiLEN", b" SuiToshi Revealed On SUI - Lets SUITosh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/39e8567a-782b-4915-8feb-849b300ede80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

