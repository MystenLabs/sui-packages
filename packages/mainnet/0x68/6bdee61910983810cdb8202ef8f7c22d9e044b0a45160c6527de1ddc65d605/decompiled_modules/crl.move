module 0x686bdee61910983810cdb8202ef8f7c22d9e044b0a45160c6527de1ddc65d605::crl {
    struct CRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRL>(arg0, 9, b"CRL", b"CIRCLE", b"CIRCLE TAP FARMING LUCKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/346a2f6d-058a-4df5-97fe-d62a7878bff8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

