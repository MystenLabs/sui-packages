module 0xdf198e4b924e8e32c06057c6f936452603b174a14496da8f2f199317692491e1::suigojo {
    struct SUIGOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOJO>(arg0, 9, b"SUIGOJO", b"Gojo", b"You wanna try this...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee1bb167-6ef4-4d38-becb-7126d30a25d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

