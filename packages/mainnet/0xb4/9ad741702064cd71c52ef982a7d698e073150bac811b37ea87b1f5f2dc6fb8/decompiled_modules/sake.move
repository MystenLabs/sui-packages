module 0xb49ad741702064cd71c52ef982a7d698e073150bac811b37ea87b1f5f2dc6fb8::sake {
    struct SAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKE>(arg0, 9, b"SAKE", b"Sake", b"Sake the snake on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmULzkvdv4JhsDDKxQDwcC6HSQcbboQyuLHmMiuYbxQFNQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAKE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

