module 0x5c02fdfb904e485b32cacaaf80f1de622649a865fb59d39c982524af1c7641af::invasion {
    struct INVASION has drop {
        dummy_field: bool,
    }

    fun init(arg0: INVASION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVASION>(arg0, 9, b"INVASION", b"INVASION ON SUI", b"2025 : Year Of Alien Invasion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYq4wmFr5hdQ64wEEZ5CjSMUEWmrzPv985ELh4u2WDmjG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<INVASION>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INVASION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INVASION>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

