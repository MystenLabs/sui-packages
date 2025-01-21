module 0x55cfd7db230b8ec7880069cbf1e32c4a394bfbd65178638ee7f0e9aa1da0cce::america {
    struct AMERICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMERICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMERICA>(arg0, 9, b"AMERICA", b"America Is Back", b"America Is Back Meme Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma6nyjbRLZKxYtGcNPTRkjGS4DuvaE8AafN5Z7kj7zXHn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AMERICA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMERICA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMERICA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

