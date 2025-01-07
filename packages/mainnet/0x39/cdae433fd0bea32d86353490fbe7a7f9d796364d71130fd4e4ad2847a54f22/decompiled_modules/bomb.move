module 0x39cdae433fd0bea32d86353490fbe7a7f9d796364d71130fd4e4ad2847a54f22::bomb {
    struct BOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMB>(arg0, 9, b"BOMB", b"Bombfire", b"Bombtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa66d4e4-29f5-45d7-b152-db5eec644124.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

