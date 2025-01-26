module 0x3fcfe6fa7007ef55bf1ea9a62a5e403ca57225c784b6e320859b86f3bfc42052::cboom {
    struct CBOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBOOM>(arg0, 9, b"CBOOM", b"Coinboom", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8793ef0-c234-4938-89a6-c90c0fc56546.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

