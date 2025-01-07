module 0xe07ce4f9d2508435e42f7f36ff67ac205f69299071b9dea16b346c3a5390bf32::culer {
    struct CULER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULER>(arg0, 9, b"CULER", b"Coolest ", b"We are here to bring a new light to crypto and better appearance for his utility ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4e56430-b7ae-4c0d-9a7c-1519c63a27b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CULER>>(v1);
    }

    // decompiled from Move bytecode v6
}

