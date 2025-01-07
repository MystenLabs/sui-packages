module 0x530d281aa418f80f63c06d97cbe7e44319cabc102714336ef78a4669a97d27d5::inys {
    struct INYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: INYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INYS>(arg0, 9, b"INYS", b"Inuyasha", b"INUYASHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d294d50c-fa6f-436c-9694-b3fb93077d59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

