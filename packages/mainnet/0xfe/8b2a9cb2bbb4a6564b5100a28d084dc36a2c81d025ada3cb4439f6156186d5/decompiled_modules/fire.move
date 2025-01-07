module 0xfe8b2a9cb2bbb4a6564b5100a28d084dc36a2c81d025ada3cb4439f6156186d5::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRE>(arg0, 9, b"FIRE", b"fear", b"light up your world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5da51824-5f51-4487-9732-7d2522620b06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

