module 0x2a6df56695ce6a67052d0b2978b0e0357148dd0942fb1e83ade7c4a04a1cf4b::sugenda {
    struct SUGENDA has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUGENDA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUGENDA>>(0x2::coin::mint<SUGENDA>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUGENDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGENDA>(arg0, 9, b"SUGEN", b"SUGENDA", b"SUGENDA the Ai girl autonomous a sweetheart, but yet a tough blue chick going into amazing ammount of data giving you real Alpha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1882277863854080000/FEsrQA5y_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUGENDA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUGENDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGENDA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

