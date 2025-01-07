module 0xcd69dba70babafb829c90b930266ab61bba3be1a6cc4b62a6c447bd6243eee8f::justinmoon {
    struct JUSTINMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTINMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTINMOON>(arg0, 9, b"JUSTINMOON", b"LABUBU", b"Your fear is my excitement :))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57c5ede5-a2e5-4fcc-a035-10690c3747e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTINMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTINMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

