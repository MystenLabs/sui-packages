module 0x563b805d40980a6703aa433fffe17891c780cba7b07fcbdf72d7affb2d8d20de::los {
    struct LOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOS>(arg0, 9, b"LOS", b"LoopOnSui", b"This cooin create only fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4ea6e1f-6222-40ab-bbff-974d0a4bf3d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

