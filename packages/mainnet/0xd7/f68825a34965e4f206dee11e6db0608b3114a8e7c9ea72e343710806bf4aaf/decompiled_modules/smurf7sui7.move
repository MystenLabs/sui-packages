module 0xd7f68825a34965e4f206dee11e6db0608b3114a8e7c9ea72e343710806bf4aaf::smurf7sui7 {
    struct SMURF7SUI7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURF7SUI7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURF7SUI7>(arg0, 6, b"SMURF7SUI7", b"SMURF7CR7", b"CristianoRonaldoSpeedSmurf7Siu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_022142350_7542a5a5a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURF7SUI7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURF7SUI7>>(v1);
    }

    // decompiled from Move bytecode v6
}

