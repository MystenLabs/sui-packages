module 0x140308025b25abb30265f02d493b34d9ce4fa18d856edde31c68e57898112f5a::cfe {
    struct CFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFE>(arg0, 9, b"CFE", b"Coffee", b"Coffee teaches us that bitterness can be enjoyed. Have you had coffee today?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c17fdca4-ce50-4096-9c8d-37b8b431d1c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

