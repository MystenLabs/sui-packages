module 0x8fcbdb432ac21b9a5a23816164e01fc5722a468ede18223967ab7e858f5d8de8::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 9, b"MSTR", b"MSTR", b"MSTR. gem. alpha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MSTR>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

