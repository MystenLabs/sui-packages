module 0x9befd5462c56df327ac3616893be68f231f6758f1a9b3af5dc498a3fdaf67aac::horse {
    struct HORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSE>(arg0, 9, b"HORSE", b"Horse Sui", b"Horse on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db4160a8-463d-406a-aadc-084c2de2fb9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

