module 0xe8f2d8a1ef3318ad89126c5dfbc5534bfb37b8d375eafc693243b17cfa76ab6e::massithecat {
    struct MASSITHECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASSITHECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASSITHECAT>(arg0, 9, b"MassiTheCat", b"MassiTheCat", b"The strong cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MASSITHECAT>(&mut v2, 9990000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASSITHECAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASSITHECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

