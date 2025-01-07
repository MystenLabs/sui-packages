module 0x7dbd8b83d84fb1dd2144535d078bc8430c364edfadcb0627efac577ff9414d80::xs {
    struct XS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XS>(arg0, 9, b"XS", b"Xsan", b"Xsan about San", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ffe629f-0c5e-4c71-8a0a-3e8d08d6f1ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XS>>(v1);
    }

    // decompiled from Move bytecode v6
}

