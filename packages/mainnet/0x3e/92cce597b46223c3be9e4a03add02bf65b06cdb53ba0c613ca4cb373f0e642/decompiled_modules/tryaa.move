module 0x3e92cce597b46223c3be9e4a03add02bf65b06cdb53ba0c613ca4cb373f0e642::tryaa {
    struct TRYAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYAA>(arg0, 9, b"TRYAA", b"TRYA", b"SD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRYAA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYAA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

