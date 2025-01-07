module 0xe204e60425ed6a80ca846f26a24bb4067dccf4033358882fb179f362b83be03a::lp_bfish {
    struct LP_BFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_BFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_BFISH>(arg0, 9, b"LP Bfish", b"LP BFish", b"Burn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LP_BFISH>(&mut v2, 983789200000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_BFISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LP_BFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

