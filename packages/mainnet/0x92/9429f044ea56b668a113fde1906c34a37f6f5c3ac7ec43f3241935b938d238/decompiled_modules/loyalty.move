module 0x929429f044ea56b668a113fde1906c34a37f6f5c3ac7ec43f3241935b938d238::loyalty {
    struct LOYALTY has drop {
        dummy_field: bool,
    }

    public entry fun award_points(arg0: &mut 0x2::coin::TreasuryCap<LOYALTY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOYALTY>>(0x2::coin::mint<LOYALTY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LOYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOYALTY>(arg0, 9, b"LOYAL", b"Loyalty Points", b"Protocol engagement and loyalty reward points", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://rewards.engine.io/loyalty.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOYALTY>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LOYALTY>>(v0);
    }

    public entry fun redeem_points(arg0: &mut 0x2::coin::TreasuryCap<LOYALTY>, arg1: 0x2::coin::Coin<LOYALTY>) {
        0x2::coin::burn<LOYALTY>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

