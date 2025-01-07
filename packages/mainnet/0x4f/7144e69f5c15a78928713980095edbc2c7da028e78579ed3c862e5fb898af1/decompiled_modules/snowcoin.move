module 0x4f7144e69f5c15a78928713980095edbc2c7da028e78579ed3c862e5fb898af1::snowcoin {
    struct SNOWCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWCOIN>(arg0, 9, b"SNOWCOIN", b"SNOWCOIN", b"ITS A SNOWY COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNOWCOIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

