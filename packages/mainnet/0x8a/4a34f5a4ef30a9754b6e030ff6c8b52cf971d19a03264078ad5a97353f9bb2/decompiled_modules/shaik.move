module 0x8a4a34f5a4ef30a9754b6e030ff6c8b52cf971d19a03264078ad5a97353f9bb2::shaik {
    struct SHAIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAIK>(arg0, 6, b"SHAIK", b"MOSHAIK", b"Best hair on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOSHAIK_bab687ddbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

