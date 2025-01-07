module 0xa11438e11b0be466e1863f4598381dbb19d5fe23df30f7048098a0b4cd6a1bde::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 8, b"WOOF", b"WOOF", b"Your $SUI wallet wil get a guaranteed Airdrop https://twitter.com/wooflabs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://twitter.com/wooflabs/photo")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOOF>(&mut v2, 30000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

