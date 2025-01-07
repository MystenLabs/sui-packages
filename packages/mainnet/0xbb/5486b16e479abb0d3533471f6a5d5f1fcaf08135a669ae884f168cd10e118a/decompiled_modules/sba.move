module 0xbb5486b16e479abb0d3533471f6a5d5f1fcaf08135a669ae884f168cd10e118a::sba {
    struct SBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBA>(arg0, 9, b"SBA", b"SABINWA", b"COMIC COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46c9a447-cd2e-4ea7-9db1-dd1cb77396f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

