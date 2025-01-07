module 0x6590f2852fcc37d25fb03974c4fad4efdd41872ad117a76932091aa4145b57ef::ksha {
    struct KSHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSHA>(arg0, 9, b"KSHA", b"kushvaha b", b"Tradeble token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fff0381f-c004-4d3b-b8fb-5ce06a7c7e0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

