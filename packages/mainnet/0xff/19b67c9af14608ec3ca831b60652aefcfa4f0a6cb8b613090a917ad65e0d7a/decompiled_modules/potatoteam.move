module 0xff19b67c9af14608ec3ca831b60652aefcfa4f0a6cb8b613090a917ad65e0d7a::potatoteam {
    struct POTATOTEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTATOTEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTATOTEAM>(arg0, 9, b"POTATOTEAM", b"Potato", x"4e657720616476656e7475726573206f6620706f7461746f65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bcfb0e2c-ac27-4633-8f09-1bbdf3e33a5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTATOTEAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTATOTEAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

