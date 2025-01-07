module 0xc0667ce25c313879f2aa8354b39752cde5a15f0151104253cf0a69e1b44a7adc::crm {
    struct CRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRM>(arg0, 9, b"CRM", b"CROMI", b"Cromi is a type of chocolate that is 75% bitter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d39d892c-812d-49b3-a7f0-6f8b002a3ee9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

