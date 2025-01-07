module 0x48705f6043e95c207baeddfea0d7dced2314dc7a9fb64e89a0f5fe80e0bbbdf2::oceanpumd {
    struct OCEANPUMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEANPUMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEANPUMD>(arg0, 9, b"OCEANPUMD", b"Oceanpumd", b"Ocean Pumd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/363fcd56-3ddc-4ab8-853c-75a33b54aded.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEANPUMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCEANPUMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

