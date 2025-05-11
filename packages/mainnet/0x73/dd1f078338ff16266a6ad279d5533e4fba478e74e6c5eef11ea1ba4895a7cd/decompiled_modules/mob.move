module 0x73dd1f078338ff16266a6ad279d5533e4fba478e74e6c5eef11ea1ba4895a7cd::mob {
    struct MOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOB>(arg0, 6, b"MOB", b"Marvin Only Boy", b"0xdd6182b8f2954c996a701171db43639b66d3699f3ee2cd7a24cd4bc935e67e24::mob::MOB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidiktaebryx7p2jn5upxba3d4tqhd5bxfgrje5b3edde27atm4wbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

