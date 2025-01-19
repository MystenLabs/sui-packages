module 0xd6d602c3255e8e6160765207fd2288cd0b9d51078d443187bb451050d7df28aa::kdx {
    struct KDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDX>(arg0, 9, b"KDX", b"Kriya DEX", b"Kriya ecosystem's native token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x3b68324b392cee9cd28eba82df39860b6b220dc89bdd9b21f675d23d6b7416f1::kdx::kdx.png?size=lg&key=e3f510")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KDX>>(0x2::coin::mint<KDX>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KDX>>(v2);
    }

    // decompiled from Move bytecode v6
}

