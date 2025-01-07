module 0xed7f164defc79a4e5d595371f5a821db353bbd00621399ce984dc05469f6a348::bug {
    struct BUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUG>(arg0, 9, b"BUG", b"Bug ", b"High", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e260824c-17bb-47d5-b5c6-9e7001963b2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

