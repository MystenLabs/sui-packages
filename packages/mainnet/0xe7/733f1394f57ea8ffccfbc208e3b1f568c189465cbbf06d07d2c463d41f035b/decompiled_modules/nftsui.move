module 0xe7733f1394f57ea8ffccfbc208e3b1f568c189465cbbf06d07d2c463d41f035b::nftsui {
    struct NFTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFTSUI>(arg0, 6, b"NFTSUI", b"TRENDZNFTSUI", x"5768656e20796f7572204a504547732061726520776f727468206d6f7265207468616e20796f757220686f7573650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_nft_1d84fa0295.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

