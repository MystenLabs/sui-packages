module 0xc279d79a6c989a4472fa214753f7b4e4311fc698869d4190b753a97923f5fe4b::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", x"5445524dc4b04e41544f52205355c4b0", b"The Terminator bull is the symbol of the season. Why not 500-600 million Mcap Sui memes in the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731257979471.35")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

