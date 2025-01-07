module 0xe7362fed2a03b166d121a770dd8d1124b493e523c0867dad7b92351e459dcccc::czx {
    struct CZX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZX>(arg0, 9, b"CZX", b"VCS", b"CZXGBV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58278c2e-4a24-49f8-9896-05b4e0fdbb10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZX>>(v1);
    }

    // decompiled from Move bytecode v6
}

