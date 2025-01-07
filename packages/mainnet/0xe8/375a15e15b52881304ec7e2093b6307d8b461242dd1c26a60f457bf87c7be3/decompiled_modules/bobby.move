module 0xe8375a15e15b52881304ec7e2093b6307d8b461242dd1c26a60f457bf87c7be3::bobby {
    struct BOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBBY>(arg0, 9, b"BOBBY", b"BOBBY", b"FIRST BOBBY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOBBY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBBY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

