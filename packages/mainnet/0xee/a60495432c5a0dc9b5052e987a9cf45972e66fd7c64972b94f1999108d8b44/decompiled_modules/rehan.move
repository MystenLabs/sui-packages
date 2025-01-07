module 0xeea60495432c5a0dc9b5052e987a9cf45972e66fd7c64972b94f1999108d8b44::rehan {
    struct REHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REHAN>(arg0, 9, b"REHAN", b"Ehann", b"ehan koin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f55c2a54-5574-476c-b8e4-baecbc3acdae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

