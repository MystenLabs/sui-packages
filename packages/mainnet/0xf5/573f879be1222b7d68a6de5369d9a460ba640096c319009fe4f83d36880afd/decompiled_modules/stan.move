module 0xf5573f879be1222b7d68a6de5369d9a460ba640096c319009fe4f83d36880afd::stan {
    struct STAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAN>(arg0, 9, b"STAN", b"stan", b"A new token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

