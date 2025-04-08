module 0xbdf600b2f3b5d2b315f0c82ad190d4b40666b823144f5013c02f26045cda98b6::tt_sui {
    struct TT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT_SUI>(arg0, 9, b"ttSUI", b"tempSUI1", b"super fast SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+v2.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

