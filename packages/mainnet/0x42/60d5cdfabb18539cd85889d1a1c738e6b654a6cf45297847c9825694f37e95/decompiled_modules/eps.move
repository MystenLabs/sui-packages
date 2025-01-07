module 0x4260d5cdfabb18539cd85889d1a1c738e6b654a6cf45297847c9825694f37e95::eps {
    struct EPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPS>(arg0, 5, b"EPS", b"Epstein", b"Welcome in the Epstein World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.bwbx.io/images/users/iqjWHBFdfxIU/ixPjDQGpheF0/v1/-1x-1.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<EPS>(&mut v2, 9999999999999900000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPS>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

