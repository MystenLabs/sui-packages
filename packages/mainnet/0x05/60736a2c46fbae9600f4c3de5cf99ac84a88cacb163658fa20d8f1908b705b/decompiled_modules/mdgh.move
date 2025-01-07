module 0x560736a2c46fbae9600f4c3de5cf99ac84a88cacb163658fa20d8f1908b705b::mdgh {
    struct MDGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDGH>(arg0, 9, b"MDGH", b"Cddvv", b"Fccfdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/093f8867-2bf7-46f4-bd12-b4a2eceb7540.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

