module 0x5f25669c805b9bc39e31c66061d96e5e0aadc86a00536b648daa82688e5bc8c0::pumb {
    struct PUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMB>(arg0, 9, b"PUMB", b"Pumbx", b"Pumb on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f61f63e-38cb-4fc1-8491-cb12b8caf8a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

