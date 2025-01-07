module 0xd4bcadbd4190560bbdabcf6a63d17a765b91225828e898315f2475e215bfbe77::dcku {
    struct DCKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCKU>(arg0, 9, b"DCKU", b"DuckyDuck", b"Token for human love duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/561bf66b-da48-491e-9433-b942a03f1e69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

