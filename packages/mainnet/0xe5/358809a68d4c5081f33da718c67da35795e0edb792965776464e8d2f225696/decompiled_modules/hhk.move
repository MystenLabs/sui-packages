module 0xe5358809a68d4c5081f33da718c67da35795e0edb792965776464e8d2f225696::hhk {
    struct HHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHK>(arg0, 9, b"HHK", b"hockey", b"Strong game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f6aa549-cd96-4684-b1b1-d507db4536e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHK>>(v1);
    }

    // decompiled from Move bytecode v6
}

