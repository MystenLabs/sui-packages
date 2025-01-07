module 0x47f508fc4307df51c4be9b5f8d57e395b8bd343ab251169e4b4e742eae6b6666::testeddddd {
    struct TESTEDDDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTEDDDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTEDDDDD>(arg0, 6, b"Testeddddd", b"test", b"tested test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/homeblackpng_edc2b78e1f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTEDDDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTEDDDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

