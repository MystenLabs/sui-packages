module 0x24ab628520f96547a8f4773113af5320c0018f69121f51beeb8c599350999ca2::liz {
    struct LIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZ>(arg0, 9, b"LIZ", b"Lizard ", x"506f70756c6172206d656d65204c697a6172642076696265732c206f776e2062792074686520636f6d6d756e697479e280a62073656e6420697420746f20746865206d6f6f6e20f09f8c9920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37c9d199-3d6f-41c7-9f3f-3e080174e6f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

