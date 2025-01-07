module 0x91ad5665a315bf40dba935dcdd346805b8a6e71f8b25f136982b7b932218fb93::meows {
    struct MEOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWS>(arg0, 9, b"MEOWS", b"MEOW", b"MOEW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8aa52245-1a38-441b-9442-ed0848c6f46c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

