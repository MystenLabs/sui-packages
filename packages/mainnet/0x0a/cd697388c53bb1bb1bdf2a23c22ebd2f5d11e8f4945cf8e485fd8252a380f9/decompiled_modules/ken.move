module 0xacd697388c53bb1bb1bdf2a23c22ebd2f5d11e8f4945cf8e485fd8252a380f9::ken {
    struct KEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEN>(arg0, 9, b"KEN", b"hdjd", b"jen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f963e671-bc5e-459b-8e6a-93221d8c8d6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

