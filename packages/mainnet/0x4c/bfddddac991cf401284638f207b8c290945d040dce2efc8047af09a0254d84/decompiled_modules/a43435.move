module 0x4cbfddddac991cf401284638f207b8c290945d040dce2efc8047af09a0254d84::a43435 {
    struct A43435 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A43435, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A43435>(arg0, 9, b"A43435", b"fdgfg", b"tretr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b6ca717-a914-4f5e-b70d-112485096e92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A43435>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A43435>>(v1);
    }

    // decompiled from Move bytecode v6
}

