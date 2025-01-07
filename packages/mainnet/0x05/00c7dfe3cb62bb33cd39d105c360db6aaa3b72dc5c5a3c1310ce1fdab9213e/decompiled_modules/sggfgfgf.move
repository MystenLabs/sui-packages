module 0x500c7dfe3cb62bb33cd39d105c360db6aaa3b72dc5c5a3c1310ce1fdab9213e::sggfgfgf {
    struct SGGFGFGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGGFGFGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGGFGFGF>(arg0, 9, b"SGGFGFGF", b"kjkjk", b"gfgfgfgf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa8e74fe-dfcb-4f10-b277-d71a3250c3d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGGFGFGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGGFGFGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

