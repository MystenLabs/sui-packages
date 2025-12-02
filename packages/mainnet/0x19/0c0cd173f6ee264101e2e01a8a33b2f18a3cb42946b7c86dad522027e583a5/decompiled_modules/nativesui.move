module 0x190c0cd173f6ee264101e2e01a8a33b2f18a3cb42946b7c86dad522027e583a5::nativesui {
    struct NATIVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NATIVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NATIVESUI>(arg0, 9, b"NATIVE SUI", b"Sui", b"Native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcShbGousewZzCa3ouAf5XpRhofEcLABAHsdLZMSfybR6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NATIVESUI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NATIVESUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NATIVESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

