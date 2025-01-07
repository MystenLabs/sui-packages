module 0x76251729229a749cf7119199b72709944eb26464fbd393c8f433f50ae86e5c96::coolx {
    struct COOLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLX>(arg0, 9, b"COOLX", b"Cool", b"Cool Elon musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad8bdf4c-52c6-4d28-8e73-df053b4e6ba9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

