module 0x817c93c14a2600a6c1923a07fdf7d7c78d5686b16e01a9daac3048e167039e3f::skinnie {
    struct SKINNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKINNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKINNIE>(arg0, 9, b"SKINNIE", b"SKINNIE on SUI", b"People say nothing is impossible but I do nothing everyday.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVAUbo4EBAC42oiUF24y4NUopzPc817yZpJmKjPogZra6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKINNIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKINNIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKINNIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

