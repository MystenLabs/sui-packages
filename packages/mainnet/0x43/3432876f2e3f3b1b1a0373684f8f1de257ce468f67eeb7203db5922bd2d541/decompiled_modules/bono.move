module 0x433432876f2e3f3b1b1a0373684f8f1de257ce468f67eeb7203db5922bd2d541::bono {
    struct BONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONO>(arg0, 6, b"BONO", b"BONO ON A BOAT WITH A CHICKEN", b"Nothing to be said here.......the meme we all needed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bono_on_a_boat_1d04a6e5bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

