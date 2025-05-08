module 0x32c17172e5226efa55e0fb847d14e4c414af7203b195f257f5130dcf0ed047e3::neptune {
    struct NEPTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUNE>(arg0, 6, b"NEPTUNE", b"NEPTUNESUI", b"Start building on sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicy6ebfuxzg3bgm7drr75jcdamskczpxkuiast2fpkk57k3z3oiam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEPTUNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

