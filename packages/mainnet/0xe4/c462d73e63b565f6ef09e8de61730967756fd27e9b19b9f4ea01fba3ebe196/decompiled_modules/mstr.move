module 0xe4c462d73e63b565f6ef09e8de61730967756fd27e9b19b9f4ea01fba3ebe196::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MSTR>, arg1: 0x2::coin::Coin<MSTR>) {
        0x2::coin::burn<MSTR>(arg0, arg1);
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 9, b"MSTR", b"MSTR2100", b"MSTR2100", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWY1vjn5bvLPCETuGgGyTeBSJWrbX27T8EZPMLwdn3B14")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MSTR>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSTR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

