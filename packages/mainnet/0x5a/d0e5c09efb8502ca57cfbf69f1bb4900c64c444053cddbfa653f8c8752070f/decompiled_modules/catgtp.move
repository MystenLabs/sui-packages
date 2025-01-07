module 0x5ad0e5c09efb8502ca57cfbf69f1bb4900c64c444053cddbfa653f8c8752070f::catgtp {
    struct CATGTP has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATGTP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CATGTP>>(0x2::coin::mint<CATGTP>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: CATGTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGTP>(arg0, 9, b"CGTP", b"CATGTP", b"First Ai cat on sui entirely ran by an autonomous agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1768738218302717952/UhXfc7jj_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATGTP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATGTP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGTP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

