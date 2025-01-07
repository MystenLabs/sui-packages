module 0x8f6b0506c4ad6aa83ccee0ca0ab87669abf251e0d139a518fd5f0b1bfadc5403::suibawave {
    struct SUIBAWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAWAVE>(arg0, 6, b"SuibaWave", b"SuibaWave SUI", b"ShibaWave ($SWAVE) is surfing the SUI blockchain, ready to take you to the moonjoin the wave today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xbbfaf4a710a3ac8f4dbca48dcd29d78cd20fc5fcbc487d5e96dad3141072c0bf_swave_swave_a33880f1ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

