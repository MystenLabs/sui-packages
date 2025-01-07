module 0x49ca83fff8e1a528f5ceb33d1db45ff96c4090e7196fe352c5e4c8c8d20b1d11::pesto {
    struct PESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESTO>(arg0, 6, b"PESTO", b"Pesto the Baby King Penguin", b"$PESTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4i6p9_U_I_400x400_7b4f15538c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

