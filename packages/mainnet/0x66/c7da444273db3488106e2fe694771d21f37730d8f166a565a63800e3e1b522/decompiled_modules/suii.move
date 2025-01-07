module 0x66c7da444273db3488106e2fe694771d21f37730d8f166a565a63800e3e1b522::suii {
    struct SUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUII>(arg0, 9, b"Suii", b"Suii", b"Sui Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUII>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

