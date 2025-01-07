module 0xa65c861a41be572d5ca00f30e0c52b3a1678a240c4589c6d592c778c6b836d84::tsm {
    struct TSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSM>(arg0, 9, b"TSM", b"TSUNAMI", b"TOKEN FOR MEMBER VANS SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e2dcf77-3afa-4614-87e8-baf0a19f282d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

