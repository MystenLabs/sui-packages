module 0x3f6e00c4fe7377335d2037819000e3d1099c2ec991ebc36c03749c4625dfdc1e::bn {
    struct BN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BN>(arg0, 9, b"BN", b"BinAli ", b"Community meme token on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c4cfdfc-079d-422e-825f-3e0a9f07a786.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BN>>(v1);
    }

    // decompiled from Move bytecode v6
}

