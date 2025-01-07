module 0x9b03d95bfa578d420d338f19fc3731acecdbb325d3b95ef9db06a31f5444e4ab::los {
    struct LOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOS>(arg0, 9, b"LOS", b"Kar", b"Xz chto eto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f79afe4-2115-4157-aea8-9ec823e31742.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

