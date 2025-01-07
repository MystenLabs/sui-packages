module 0x818690ce5196a6fad9fdf8c661fa2abd24bac04e9665149a8eb24337b01f7e58::rmd {
    struct RMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMD>(arg0, 9, b"RMD", b"Real Madri", b"The Biggest Football Team in the world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f696062-1f66-461f-9a1e-3403f566de0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

