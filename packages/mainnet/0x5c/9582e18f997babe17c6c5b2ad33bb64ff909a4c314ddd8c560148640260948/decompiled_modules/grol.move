module 0x5c9582e18f997babe17c6c5b2ad33bb64ff909a4c314ddd8c560148640260948::grol {
    struct GROL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROL>(arg0, 9, b"Grol", b"troltest", b"its a test just chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GROL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROL>>(v1);
    }

    // decompiled from Move bytecode v6
}

