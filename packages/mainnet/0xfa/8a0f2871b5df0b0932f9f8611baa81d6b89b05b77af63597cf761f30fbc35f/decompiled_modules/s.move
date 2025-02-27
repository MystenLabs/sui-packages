module 0xfa8a0f2871b5df0b0932f9f8611baa81d6b89b05b77af63597cf761f30fbc35f::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 9, b"S", b"s", b"s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzqBvzdVf-9AKTWLtxFIOKkqPY_K9pOViKMA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<S>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<S>>(v2);
    }

    // decompiled from Move bytecode v6
}

