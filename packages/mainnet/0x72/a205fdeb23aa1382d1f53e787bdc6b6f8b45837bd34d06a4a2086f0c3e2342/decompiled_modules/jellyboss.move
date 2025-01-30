module 0x72a205fdeb23aa1382d1f53e787bdc6b6f8b45837bd34d06a4a2086f0c3e2342::jellyboss {
    struct JELLYBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYBOSS>(arg0, 9, b"jellyboss", b"jelly-boss-jelly", b"from these cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-wooden-manatee-168.mypinata.cloud/ipfs/bafkreihnx56hco7iaqu7uri4zqv3mwnzulqxjrkmfe5nwu5pxsdasgubym")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JELLYBOSS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLYBOSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYBOSS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

