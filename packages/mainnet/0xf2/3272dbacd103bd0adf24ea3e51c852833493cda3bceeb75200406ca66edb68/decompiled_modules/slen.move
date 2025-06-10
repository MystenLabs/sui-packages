module 0xf23272dbacd103bd0adf24ea3e51c852833493cda3bceeb75200406ca66edb68::slen {
    struct SLEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEN>(arg0, 6, b"SLEN", b"Sui Slender", x"24534c454e2c207468652053554920536c656e64657220436f696e0a41206d7973746572696f757320677561726469616e206f66207468652053554920466f726573742e204461726b2e20506f77657266756c2e20556e73746f707061626c652e2024534c454e20636f6d62696e65732063756c7420656e65726779207769746820766972616c206d6f6d656e74756d20666f722074686f736520756e616672616964206f662074686520736861646f77732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicjt7fdmfiy4iwtncp3wxbgeiju2zcey6gzdkp354msmb4vgelrgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

