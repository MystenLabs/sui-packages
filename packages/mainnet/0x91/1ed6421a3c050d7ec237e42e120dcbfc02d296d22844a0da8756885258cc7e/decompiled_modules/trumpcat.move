module 0x911ed6421a3c050d7ec237e42e120dcbfc02d296d22844a0da8756885258cc7e::trumpcat {
    struct TRUMPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPCAT>(arg0, 9, b"TrumpCat", b"Trump Cat Family", b"New Era For Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZMZc4q5DdTDX2LHvFfSBxrsmpPg52BUT2cPMYEBCKGtz")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

