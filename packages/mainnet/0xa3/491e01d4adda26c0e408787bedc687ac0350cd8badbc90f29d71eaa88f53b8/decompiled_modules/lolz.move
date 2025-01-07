module 0xa3491e01d4adda26c0e408787bedc687ac0350cd8badbc90f29d71eaa88f53b8::lolz {
    struct LOLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLZ>(arg0, 9, b"LOLZ", b"Chucklez", b"Chucklez is bring the fun all along with efficiency of meme experience", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1639006959256084480/5n3Cdt1D.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOLZ>(&mut v2, 700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

