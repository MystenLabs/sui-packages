module 0xcd374963fa4327370bf0f5bd28153f0d44b50f3053caed97ba55f4ee522d55c::cfe {
    struct CFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFE>(arg0, 9, b"CFE", b"Coffee", b"Coffee teaches us that bitterness can be enjoyed. Have you had coffee today?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9534313e-e853-4a18-8806-f5808e50e4e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

