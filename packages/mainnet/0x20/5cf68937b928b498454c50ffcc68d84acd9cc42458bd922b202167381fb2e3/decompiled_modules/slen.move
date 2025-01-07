module 0x205cf68937b928b498454c50ffcc68d84acd9cc42458bd922b202167381fb2e3::slen {
    struct SLEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEN>(arg0, 9, b"SLEN", b"SuitosiLEN", b" SuiToshi Revealed On SUI - Lets SUITosh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/531d0cae-65b3-4810-8ffb-b772c71d98a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

