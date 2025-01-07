module 0xdcaa3facb40e8c178819662154d3b9a7e7889be99ead4b1190c14d9f47cee0fc::coolx {
    struct COOLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLX>(arg0, 9, b"COOLX", b"Cool", b"Cool Elon musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67fcd3d6-75d2-4820-8b13-b93c9367a9ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

