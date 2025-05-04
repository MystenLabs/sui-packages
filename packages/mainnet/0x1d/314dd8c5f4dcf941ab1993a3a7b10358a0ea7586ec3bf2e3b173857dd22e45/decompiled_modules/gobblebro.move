module 0x1d314dd8c5f4dcf941ab1993a3a7b10358a0ea7586ec3bf2e3b173857dd22e45::gobblebro {
    struct GOBBLEBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBBLEBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBBLEBRO>(arg0, 9, b"GOBBL", b"Gobblebro", x"546865206b696e67206f6620736e61636b7320616e642064697073e28094476f62626c6562726f20676f62626c657320636f696e7320616e64207374696c6c2077616e7473206d6f726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihoqvljap7ji7id3go67dneltbk3duhfyn2voxxo2caveb4jbu3oy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOBBLEBRO>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBBLEBRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBBLEBRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

