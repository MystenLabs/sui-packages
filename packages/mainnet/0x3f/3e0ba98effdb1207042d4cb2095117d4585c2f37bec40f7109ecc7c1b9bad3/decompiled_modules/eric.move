module 0x3f3e0ba98effdb1207042d4cb2095117d4585c2f37bec40f7109ecc7c1b9bad3::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIC>(arg0, 9, b"ERIC", b"OFFICIAL ERIC", b"Unique red fun $ERIC meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdMxHDaLS7KsUEKFqFYRAEgrPy8BRyR2zR3tmpZBy8sfi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ERIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

