module 0xa4681f509973cc2aeb862c3027199fcba3e6fd44c7ef31005819ceb4ed55075::rck {
    struct RCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCK>(arg0, 9, b"RCK", b"red cake", b"delicious", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aadb42f1-ae6f-40bf-a170-f3e948ba5980.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

