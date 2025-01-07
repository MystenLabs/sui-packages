module 0x30f682d5381f53aa3425b0399a31198178342f0a5fa9f5e506eb1a442925c569::cta {
    struct CTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTA>(arg0, 9, b"CTA", b"Camelot", b"RU Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc122488-05de-4c2d-9859-30c377a7e384.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

