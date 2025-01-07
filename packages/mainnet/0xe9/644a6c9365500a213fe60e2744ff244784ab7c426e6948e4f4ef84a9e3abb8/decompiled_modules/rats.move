module 0xe9644a6c9365500a213fe60e2744ff244784ab7c426e6948e4f4ef84a9e3abb8::rats {
    struct RATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATS>(arg0, 6, b"RATS", b"SUIRATS", b"SUI Rat army unite!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_135525_c4d461670f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

