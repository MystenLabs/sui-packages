module 0xd2668445931654d1de41b02f3af6f3b0a4b789af95782a869d6f36d36e32d491::iron {
    struct IRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRON>(arg0, 9, b"IRON", b"Iron Sui", b"Iron Sui is an Iron Man who holds Sui on his body.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96dd2559-0310-40a8-b918-3cbbd1a9cfad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

