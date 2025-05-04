module 0x1efbe5367aa59b2f14aabc45ce065101d16238b94002c8c290fcafa6edfa0ea4::napoleoncat {
    struct NAPOLEONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAPOLEONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAPOLEONCAT>(arg0, 9, b"NAPCAT", b"Napoleoncat", b"For those with big goals and even bigger naps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiabplstholubwvtreq2idrb6rjmyywfqvk2i6uj3doh4rnbrlnlxu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAPOLEONCAT>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAPOLEONCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAPOLEONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

