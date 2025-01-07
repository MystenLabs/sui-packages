module 0xd3e8fc47d8b077ea99af7019785b592535273ad615c722d2343b08444cbb29f::gzbaykal {
    struct GZBAYKAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZBAYKAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GZBAYKAL>(arg0, 9, b"GZBAYKAL", b"ZmeyKa", x"d0bcd0bed0b920d182d0bed0bad0b5d0bd20d0bdd0b020d0bfd0b0d0bcd18fd182d18c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8c5a5df-4819-40e3-860f-ec31b599892b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GZBAYKAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GZBAYKAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

