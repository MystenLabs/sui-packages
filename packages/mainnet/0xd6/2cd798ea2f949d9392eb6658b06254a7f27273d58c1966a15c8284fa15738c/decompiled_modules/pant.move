module 0xd62cd798ea2f949d9392eb6658b06254a7f27273d58c1966a15c8284fa15738c::pant {
    struct PANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANT>(arg0, 9, b"PANT", b"Panetra", b"Pantera meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b906ac7d-7735-4af1-9c8b-88e5bcf8bc19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

