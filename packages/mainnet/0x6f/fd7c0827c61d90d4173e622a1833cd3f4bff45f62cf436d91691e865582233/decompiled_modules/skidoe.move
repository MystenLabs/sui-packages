module 0x6ffd7c0827c61d90d4173e622a1833cd3f4bff45f62cf436d91691e865582233::skidoe {
    struct SKIDOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIDOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIDOE>(arg0, 9, b"SKIDOE", b"SKI MASK RABBIT", b"SKI MASK RABBIT meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x2b3d9781d1784941865f91de772bb459d2c815b5.png?size=xl&key=bc00c4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKIDOE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKIDOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIDOE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

