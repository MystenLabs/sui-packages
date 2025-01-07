module 0x870425ed7c19aa87f19bd29ca75b2c5134f023de5880937fcc767c05f0ba4bec::justinmoon {
    struct JUSTINMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTINMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTINMOON>(arg0, 9, b"JUSTINMOON", b"LABUBU", b"Your fear is my excitement :))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00653965-c381-4afe-8d8b-4265c967aabe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTINMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTINMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

