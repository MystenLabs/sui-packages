module 0xf4391512a907a149472542c553511c9db54383b46f6252b4f286bc6a9e5ce4e1::neptune {
    struct NEPTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUNE>(arg0, 6, b"NEPTUNE", b"NEPTUNESUI", b"Building tools that makes trading and interaction on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicy6ebfuxzg3bgm7drr75jcdamskczpxkuiast2fpkk57k3z3oiam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEPTUNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

