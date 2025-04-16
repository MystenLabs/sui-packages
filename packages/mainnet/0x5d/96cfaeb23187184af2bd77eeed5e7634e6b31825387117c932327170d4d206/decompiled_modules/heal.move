module 0x5d96cfaeb23187184af2bd77eeed5e7634e6b31825387117c932327170d4d206::heal {
    struct HEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAL>(arg0, 6, b"Heal", b"Heal the people", b"Each transaction to heal people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibdikm57woq3cy3jwo4rp2mcbsjzwm7ooknvtb6ri344dthejnd4e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

