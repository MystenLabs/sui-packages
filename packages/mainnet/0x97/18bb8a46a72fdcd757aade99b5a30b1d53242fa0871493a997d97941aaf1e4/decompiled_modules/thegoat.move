module 0x9718bb8a46a72fdcd757aade99b5a30b1d53242fa0871493a997d97941aaf1e4::thegoat {
    struct THEGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEGOAT>(arg0, 6, b"THEGOAT", b"SUIIIIII", x"4e6f207477656574732c206e6f206772616d2c206a75737420676f6174696e6720616e642070756d70200a0a535549494949494949494949494949", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5215488996849870917_ad4c8b4084.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

