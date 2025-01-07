module 0xbc16a03f2dd380aa619e1239aafec444df3f48a8774ade7735c9edf0d02091cf::jwnetwork {
    struct JWNETWORK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JWNETWORK>, arg1: 0x2::coin::Coin<JWNETWORK>) {
        0x2::coin::burn<JWNETWORK>(arg0, arg1);
    }

    fun init(arg0: JWNETWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWNETWORK>(arg0, 9, b"jwnetwork", b"JWORG", b"Network ecosystem for digital service of Jehovah's Witnesses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/FoPHuHm.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JWNETWORK>>(v1);
        0x2::coin::mint_and_transfer<JWNETWORK>(&mut v2, 1440000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JWNETWORK>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JWNETWORK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JWNETWORK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

