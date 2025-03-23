module 0x7afd8148f248bf14b6f1cb41384baf34e7574790201bfb08b71493d82ba85e9c::valet {
    struct VALET has drop {
        dummy_field: bool,
    }

    fun init(arg0: VALET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VALET>(arg0, 9, b"Valet", b"Valet Agents", b"Empower your Twitter presence with Valent Agent  the simplest way for non-techies to create and automate their own AI agent! No coding needed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNTdW3hEv6Zct3KC9SrTC5Cq56F5xmLAm7RQJFXEryshX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VALET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VALET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VALET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

