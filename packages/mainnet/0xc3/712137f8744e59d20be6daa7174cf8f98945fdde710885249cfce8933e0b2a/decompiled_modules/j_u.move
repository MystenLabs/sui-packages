module 0xc3712137f8744e59d20be6daa7174cf8f98945fdde710885249cfce8933e0b2a::j_u {
    struct J_U has drop {
        dummy_field: bool,
    }

    fun init(arg0: J_U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J_U>(arg0, 9, b"J_U", b"Junaid Ur ", b"@junaidurrehmam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40aeb8b8-61f1-4a24-b19a-795efbdf0049.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J_U>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J_U>>(v1);
    }

    // decompiled from Move bytecode v6
}

