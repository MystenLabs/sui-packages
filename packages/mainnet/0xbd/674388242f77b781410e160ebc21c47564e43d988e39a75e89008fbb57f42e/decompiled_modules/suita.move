module 0xbd674388242f77b781410e160ebc21c47564e43d988e39a75e89008fbb57f42e::suita {
    struct SUITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITA>(arg0, 9, b"SUITA", b"SUITANI", x"546865206d656d6520636f696e2053554954414e492066726f6d205355492e0a497420736f6d65686f7720726573656d626c657320746865206d6f6d656e74756d206f66205355492e204c6574277320737570706f72742068696d210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0765489e-729e-4521-9be8-b805065d50e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

