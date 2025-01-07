module 0x8e629e814947eebfbc61b7ce7672bb563dd5fb8ec90e7853ac742fc0198f131f::bill {
    struct BILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILL>(arg0, 9, b"BILL", b"Metamask Fox", b"Metamask Fox , call now Bill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/QmRcrfQfJsZxzgFt4aqvwAt9S662F6ym7zMGSLXYfkXhYC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BILL>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

