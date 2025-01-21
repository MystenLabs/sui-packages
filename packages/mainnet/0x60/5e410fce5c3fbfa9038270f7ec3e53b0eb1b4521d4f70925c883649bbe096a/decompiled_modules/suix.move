module 0x605e410fce5c3fbfa9038270f7ec3e53b0eb1b4521d4f70925c883649bbe096a::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 6, b"SUIX", b"Syber SUI", b"Syber Sui is a meme coin from the future, here to boost the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737497760748.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

