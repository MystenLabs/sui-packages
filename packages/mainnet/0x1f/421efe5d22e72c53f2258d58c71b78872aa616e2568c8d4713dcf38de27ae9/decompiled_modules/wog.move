module 0x1f421efe5d22e72c53f2258d58c71b78872aa616e2568c8d4713dcf38de27ae9::wog {
    struct WOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOG>(arg0, 9, b"WOG", b"WOG whale", b"Wave OGs lover", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a4316e0-2dfb-4299-bf4e-cdc03033382f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

