module 0xfb34d4cdd832cdc8a2d9242f4790facac2b5f88380bc04b54bb9b4e70c8a372b::bwave {
    struct BWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWAVE>(arg0, 9, b"BWAVE", b"BabyWave", b"\"Dive into the future of crypto with BabyWave, where waves of innovation meet boundless potential. Surf the wave of success!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1674643b-5252-4e42-8645-6f69bb00f88b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

