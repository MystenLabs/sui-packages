module 0x3d85838376113a252245a4c95860aaf31bb06463fc6c1d8f64a655e49d0d76ac::asnasir {
    struct ASNASIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASNASIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASNASIR>(arg0, 9, b"ASNASIR", b"ASN", b"ASN WEWE SUI PUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10b036c6-5bf4-4b6c-b730-04a6f06056e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASNASIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASNASIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

