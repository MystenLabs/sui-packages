module 0xc1e24be8d5c02150ff271aa6aca7b86b485685c5af50eaaa5ef987b1da2e1fe9::estalink {
    struct ESTALINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTALINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTALINK>(arg0, 9, b"ESTALINK", b"ELONSTAR", b"Starlink, the interstellar meme coin that's out of this world! Inspired by the revolutionary Space Starlink satellite constellation, this token is poised to reach new heights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71230bf2-c6f2-47ed-89e5-aa86b9b24fae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTALINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESTALINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

