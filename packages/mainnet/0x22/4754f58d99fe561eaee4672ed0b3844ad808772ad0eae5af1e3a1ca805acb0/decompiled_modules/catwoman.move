module 0x224754f58d99fe561eaee4672ed0b3844ad808772ad0eae5af1e3a1ca805acb0::catwoman {
    struct CATWOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWOMAN>(arg0, 9, b"CATWOMAN", x"f09f90b1436174776f6d616e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATWOMAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWOMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATWOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

