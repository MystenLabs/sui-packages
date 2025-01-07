module 0x4d1aa5ba2cadcc35b80983f24ff3c35e9fa3d6f1e38dc089db75a4ed6c76bfa4::robco {
    struct ROBCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBCO>(arg0, 9, b"ROBCO", b"RobinsonGl", b"Robbin son coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9cc6bc2f-63b1-4568-a136-53265226f5e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

