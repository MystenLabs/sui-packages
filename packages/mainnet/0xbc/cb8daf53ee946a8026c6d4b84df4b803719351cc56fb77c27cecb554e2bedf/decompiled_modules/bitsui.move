module 0xbccb8daf53ee946a8026c6d4b84df4b803719351cc56fb77c27cecb554e2bedf::bitsui {
    struct BITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITSUI>(arg0, 9, b"BITSUI", b"HarryPotterTrumpHippo69Inu", b"$BITSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/WtdsGy7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BITSUI>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

