module 0x3223f5efb0041d4b39070e8fd9768f9bc7674dac085440cd4743f6537996fc0f::purtem {
    struct PURTEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURTEM>(arg0, 9, b"PURTEM", b"purteme", b"community driven.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85de802a-b03d-4f7e-ae2a-bd164ed62996.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURTEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PURTEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

