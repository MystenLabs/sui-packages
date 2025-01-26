module 0xc95a8bf9277596cd15e98b2cd5e3920e34efd3bb85a7786de28d0d9446426dba::zel {
    struct ZEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEL>(arg0, 9, b"ZEL", b"Zelenskyy", b"0x01e07df8db71f6f24b8f5829c8ce250d5c2bb5e3adae7bc60cd517f4a552d72b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e04d63c5-a7d8-48ef-a34a-77acf83232c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

