module 0x4056bad3bde960927e75151021b8b4796759ad5eed110a13d5f7221bc8edd799::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"SIUUUU", b"Ronaldo scores his way to the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmlsuyacsbwvwfiobutbu6n36x4slzwv3lzyfpkek725f5ygaaxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

