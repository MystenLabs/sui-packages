module 0xfcca00c74dbfde635c46009322ce1c3f46b3178a72075fd7ed9b2bd5cc5b9143::algo {
    struct ALGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALGO>(arg0, 6, b"ALGO", b"Algo", b"$ALGO Is inspired by the legendary puffer, the og party fish of thr reef, dive in and join to the surreal journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052741_69d50f7bc8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

