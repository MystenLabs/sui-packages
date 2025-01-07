module 0x372cbfdfa965dba6d026bdbddfe3f91395ff6f9c7a02e9501654a9482cec33a5::gal {
    struct GAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAL>(arg0, 9, b"GAL", b"Galahad", b"Galahad of web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/052d1f1c-7dc1-41c3-896f-174f70b28624.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

