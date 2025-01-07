module 0x1711dc861a82ed3cd399e7c7e88f874eeb918925abe4af3e847cdeb843316ff2::soal {
    struct SOAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAL>(arg0, 6, b"SOAL", b"Sonic The Seal", b"Sonic Seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6512_181faeb089.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

