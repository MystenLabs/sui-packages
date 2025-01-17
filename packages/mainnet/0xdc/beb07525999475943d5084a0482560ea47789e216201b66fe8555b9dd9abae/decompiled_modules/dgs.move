module 0xdcbeb07525999475943d5084a0482560ea47789e216201b66fe8555b9dd9abae::dgs {
    struct DGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGS>(arg0, 9, b"DGS", b"Degenus", b"Degenus coin for degens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3799130a-662e-4870-9b20-e5015df6e05c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

