module 0xad5e7d53fcd4adb2645809d53e8e4836269f802fbad9cd968e6f6bf31c8eae24::yal {
    struct YAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAL>(arg0, 9, b"YAL", b"YALE TOKEN", b"A community based token created to help fight child abuse in africa. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b896617a-f9a5-4231-942f-5f275e4241bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

