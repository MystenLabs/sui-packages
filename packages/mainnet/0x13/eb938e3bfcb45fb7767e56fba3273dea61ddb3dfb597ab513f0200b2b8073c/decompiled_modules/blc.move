module 0x13eb938e3bfcb45fb7767e56fba3273dea61ddb3dfb597ab513f0200b2b8073c::blc {
    struct BLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLC>(arg0, 9, b"BLC", b"BLACKCATS", x"44757261626c6520616e642061747472616374697665206469676974616c2063757272656e63790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae1ce15a-8be3-4c5e-8e04-700f20a5f83e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

