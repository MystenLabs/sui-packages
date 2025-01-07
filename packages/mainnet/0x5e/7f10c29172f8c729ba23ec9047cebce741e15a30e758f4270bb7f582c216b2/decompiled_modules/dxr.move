module 0x5e7f10c29172f8c729ba23ec9047cebce741e15a30e758f4270bb7f582c216b2::dxr {
    struct DXR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXR>(arg0, 9, b"DXR", b"Dxster", b"Dxster coin is a cryptocurrency inspired by internet memes or popular culture trends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c29998a-418e-4e33-953f-fa2fef9ce7c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXR>>(v1);
    }

    // decompiled from Move bytecode v6
}

