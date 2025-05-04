module 0x683873001a014660ac8a1c51d8d90c5b9f5e17e1617166b6c8fdccd08de4235f::mlemmy {
    struct MLEMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLEMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLEMMY>(arg0, 9, b"MLEM", b"Mlemmy", b"Here for the snacks, and the pumps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidzjwbycui3vcyeluumavui6pem2ex2pukvqvewoaraninz2xf4ae")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MLEMMY>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLEMMY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLEMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

