module 0xcd457c64e19a504a01ad80638a56a8080e9708c881d0d026efc2b8549a5ae413::party {
    struct PARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARTY>(arg0, 9, b"PARTY", b"SUI MEME PARTY", b"Welcome to the best meme party since the last memecoin season, only on the", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1839078636290203648/CcFcWlr__400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PARTY>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

