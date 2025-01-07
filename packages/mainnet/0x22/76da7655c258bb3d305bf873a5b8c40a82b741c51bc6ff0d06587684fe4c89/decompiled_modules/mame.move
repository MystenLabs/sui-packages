module 0x2276da7655c258bb3d305bf873a5b8c40a82b741c51bc6ff0d06587684fe4c89::mame {
    struct MAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAME>(arg0, 9, b"MAME", b"mameshiba", x"0a546869732069732061206d656d6520636f696e206f66206120736d616c6c20536869626120496e752c204d616d6573686962612e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a5cb5ba-f0ee-4205-8746-4d70d62ca801.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

