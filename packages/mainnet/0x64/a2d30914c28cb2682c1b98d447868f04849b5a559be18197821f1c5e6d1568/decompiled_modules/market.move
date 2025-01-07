module 0x64a2d30914c28cb2682c1b98d447868f04849b5a559be18197821f1c5e6d1568::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARKET>(arg0, 6, b"Market", b"Market Open", b"Sui Meme Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zk_S7_Rv_WMA_Eq_Pa9_7a52bcb838.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

