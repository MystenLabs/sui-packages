module 0x8b5c623ba4d6c4a3ac5b2bced9338e89ba7d4a9775930c8f6865fb5bea174019::DOGESUN {
    struct DOGESUN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGESUN>, arg1: 0x2::coin::Coin<DOGESUN>) {
        0x2::coin::burn<DOGESUN>(arg0, arg1);
    }

    fun init(arg0: DOGESUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUN>(arg0, 9, b"SUP", b"DOGESUN", b"https://imgbb.com/][img]https://i.ibb.co/D5VR7zc/dogesun.jpg", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGESUN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGESUN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

