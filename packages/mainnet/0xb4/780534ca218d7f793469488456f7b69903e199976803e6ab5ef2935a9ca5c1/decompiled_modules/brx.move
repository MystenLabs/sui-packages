module 0xb4780534ca218d7f793469488456f7b69903e199976803e6ab5ef2935a9ca5c1::brx {
    struct BRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRX>(arg0, 9, b"BRX", b"BadraEX", b"Great and good DEX on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5092f4dd-9701-40c5-877f-570f2f99f8f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

