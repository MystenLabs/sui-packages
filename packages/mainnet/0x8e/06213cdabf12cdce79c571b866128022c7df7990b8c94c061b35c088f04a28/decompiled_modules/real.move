module 0x8e06213cdabf12cdce79c571b866128022c7df7990b8c94c061b35c088f04a28::real {
    struct REAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REAL>(arg0, 9, b"REAL", b"Kachalla", b"A  very potent far reaching meme coin with lots of portfolio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c43deba-184b-40d1-9c1b-3939aebb6a18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

