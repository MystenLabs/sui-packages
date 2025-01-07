module 0x90e57b974c5f488fa1b0e5d9091a0e64847f908dce0d3e47f20e28d20cd7a021::apest {
    struct APEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEST>(arg0, 9, b"APEST", b"APES", b"APES TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b00e2d7-99a2-403a-944a-4d07256feff1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

