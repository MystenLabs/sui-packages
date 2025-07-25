module 0x112eb3214d301e1d241d28a232cdb606b1ed8fb1d03b04e84340e2b6a0942aad::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"Bobzilla on SUI", x"4920616d20426f627a696c6c6120200a547279206f7574206f757220766f6c756d6520626f74200a40737569626f6f73746572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifycdbmmxcid2njgu5aosufuukwz5j4jr56m4c3mi64exur4dyxme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

