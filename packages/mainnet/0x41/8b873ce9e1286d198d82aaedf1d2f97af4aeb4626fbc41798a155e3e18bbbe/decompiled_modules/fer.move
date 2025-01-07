module 0x418b873ce9e1286d198d82aaedf1d2f97af4aeb4626fbc41798a155e3e18bbbe::fer {
    struct FER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FER>(arg0, 9, b"FER", b"hhh", b"hjvh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdc9f0ea-5092-44ca-8e88-fcb88ceb7263.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FER>>(v1);
    }

    // decompiled from Move bytecode v6
}

