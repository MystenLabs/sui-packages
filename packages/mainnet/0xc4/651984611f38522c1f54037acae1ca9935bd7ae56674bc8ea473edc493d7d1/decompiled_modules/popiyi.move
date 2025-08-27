module 0xc4651984611f38522c1f54037acae1ca9935bd7ae56674bc8ea473edc493d7d1::popiyi {
    struct POPIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPIYI>(arg0, 9, b"POPIYI", b"POPIYI", b"POP POP POP POP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPIYI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPIYI>>(v2, @0x1516a2df9237a7573b49c5e2fc9fc18808c8c9a5417e1bc7ef276b1029717978);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPIYI>>(v1);
    }

    // decompiled from Move bytecode v6
}

