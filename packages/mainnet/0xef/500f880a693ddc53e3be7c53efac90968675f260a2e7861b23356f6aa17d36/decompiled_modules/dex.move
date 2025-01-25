module 0xef500f880a693ddc53e3be7c53efac90968675f260a2e7861b23356f6aa17d36::dex {
    struct DEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEX>(arg0, 6, b"DEX", b"Dexscreener", b"Do not ape this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dexscreener_logo_54e6206b53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

