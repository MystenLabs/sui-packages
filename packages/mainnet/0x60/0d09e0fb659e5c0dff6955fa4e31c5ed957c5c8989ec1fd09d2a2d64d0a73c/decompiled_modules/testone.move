module 0x600d09e0fb659e5c0dff6955fa4e31c5ed957c5c8989ec1fd09d2a2d64d0a73c::testone {
    struct TESTONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTONE>(arg0, 9, b"TestOne", b"TestOne", b"TestOnef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTONE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTONE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

