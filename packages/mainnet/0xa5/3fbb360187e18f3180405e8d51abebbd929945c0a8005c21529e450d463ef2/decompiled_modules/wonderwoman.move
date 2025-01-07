module 0xa53fbb360187e18f3180405e8d51abebbd929945c0a8005c21529e450d463ef2::wonderwoman {
    struct WONDERWOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONDERWOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONDERWOMAN>(arg0, 9, b"WONDERWOMAN", x"f09f92a5574f4e444552574f4d414e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WONDERWOMAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONDERWOMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WONDERWOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

