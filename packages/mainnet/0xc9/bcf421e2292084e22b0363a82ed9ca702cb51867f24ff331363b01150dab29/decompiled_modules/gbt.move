module 0xc9bcf421e2292084e22b0363a82ed9ca702cb51867f24ff331363b01150dab29::gbt {
    struct GBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBT>(arg0, 6, b"GBT", b"Gigglebucks ", b"Welcome to the whimsical world of **Gigglebucks (GBT)**, the digital currency designed to tickle your funny bone and your bank balance. Tired of boring old coins? Gigglebucks brings the LOLs straight to your wallet,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731636566702.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

