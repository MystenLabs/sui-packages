module 0x189df20872b7c3f6889e63906d7392bc434176072abdbd67c529873b5ed464cc::hama {
    struct HAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMA>(arg0, 6, b"HAMA", b"Sui HAMA", b"I am HAMA - baby hippo in vietnamese. I am 4 months old and I just was born in Ha Noi - Vietnam on July 23, 2024. My home: hanoizoo.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731334578734.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

