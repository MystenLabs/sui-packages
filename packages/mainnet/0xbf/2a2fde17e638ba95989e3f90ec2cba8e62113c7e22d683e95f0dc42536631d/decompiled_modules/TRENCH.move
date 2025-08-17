module 0xbf2a2fde17e638ba95989e3f90ec2cba8e62113c7e22d683e95f0dc42536631d::TRENCH {
    struct TRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCH>(arg0, 6, b"Trench Token", b"TRENCH", x"4469766520696e746f20746865205452454e434820616e6420656d657267652077697468206761696e73212041206d656d6520636f696e20666f722074686f73652077686f206772696e6420696e207468652063727970746f207472656e636865732e204e6f20726574726561742c206e6f2073757272656e646572e280946a75737420686f646c20616e64206469672064656570657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafybeifv4zraonj6is32lgdfpiebs6ty6vogfahcnwcjrmcm45cdnerwv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCH>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

