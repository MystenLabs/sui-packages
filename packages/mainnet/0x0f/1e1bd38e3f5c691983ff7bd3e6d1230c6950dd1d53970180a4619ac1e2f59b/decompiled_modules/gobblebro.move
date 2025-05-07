module 0xf1e1bd38e3f5c691983ff7bd3e6d1230c6950dd1d53970180a4619ac1e2f59b::gobblebro {
    struct GOBBLEBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBBLEBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBBLEBRO>(arg0, 9, b"GOBBL", b"Gobblebro", x"546865206b696e67206f6620736e61636b7320616e642064697073e28094476f62626c6562726f20676f62626c657320636f696e7320616e64207374696c6c2077616e7473206d6f726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihoqvljap7ji7id3go67dneltbk3duhfyn2voxxo2caveb4jbu3oy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOBBLEBRO>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBBLEBRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBBLEBRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

