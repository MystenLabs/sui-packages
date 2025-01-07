module 0x6ea060e250b784324fabae32d8c65231588d82b766e51737e6af69077f9a0a69::baba {
    struct BABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABA>(arg0, 9, b"BABA", b"Baby panda", b"Meme season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f096d594-823c-4214-9441-4e10a53af27b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

