module 0x7933a8d5b18b88d810b27a7f1302786986f22397976d6dee6b30e7fca9af985a::peanut86 {
    struct PEANUT86 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT86, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT86>(arg0, 9, b"PEANUT86", b"Peanut", b"Leanut is the extremely cute puppy of a young billionaire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60931cc2-6721-4785-ad13-f23abf489792.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUT86>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEANUT86>>(v1);
    }

    // decompiled from Move bytecode v6
}

