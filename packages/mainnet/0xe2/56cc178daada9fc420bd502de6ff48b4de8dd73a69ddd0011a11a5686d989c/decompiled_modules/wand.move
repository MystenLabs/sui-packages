module 0xe256cc178daada9fc420bd502de6ff48b4de8dd73a69ddd0011a11a5686d989c::wand {
    struct WAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAND>(arg0, 9, b"WAND", b"WANDCAT", b"Wandcat is a meme that will move the community from trenches to mansions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c377e3d5-436e-4422-a7ec-479ce7a08843.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

