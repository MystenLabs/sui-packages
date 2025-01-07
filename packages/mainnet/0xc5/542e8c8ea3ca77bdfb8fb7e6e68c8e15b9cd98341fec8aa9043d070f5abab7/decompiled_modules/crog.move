module 0xc5542e8c8ea3ca77bdfb8fb7e6e68c8e15b9cd98341fec8aa9043d070f5abab7::crog {
    struct CROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROG>(arg0, 9, b"CROG", b"Sui Crog", b"I'm a creature with the body of a cat and the hind legs of a frog. CROG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmVAKSzPunHb9MKAkJ2J66JEyVRqmL9QsNdTbNYXVLyJMz?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CROG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

