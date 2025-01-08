module 0xf18b77f7cbab2e769f061b20af04fe9b299f5eb7a337fbf4d8275e7abe30faa::tryingbethh {
    struct TRYINGBETHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYINGBETHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYINGBETHH>(arg0, 9, b"TRYINGBETHH", b"TRYINGBETH", b"sd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRYINGBETHH>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYINGBETHH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYINGBETHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

