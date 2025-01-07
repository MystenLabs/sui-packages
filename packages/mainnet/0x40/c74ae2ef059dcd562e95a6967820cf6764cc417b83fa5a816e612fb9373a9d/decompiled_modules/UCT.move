module 0x40c74ae2ef059dcd562e95a6967820cf6764cc417b83fa5a816e612fb9373a9d::UCT {
    struct UCT has drop {
        dummy_field: bool,
    }

    public entry fun admin_transfer(arg0: 0x2::coin::TreasuryCap<UCT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCT>>(arg0, arg1);
    }

    fun init(arg0: UCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCT>(arg0, 6, b"UCT", b"USD Coupon Token", b"USD Coupon Token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<UCT>>(0x2::coin::mint<UCT>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_uct(arg0: &mut 0x2::coin::Coin<UCT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UCT>>(0x2::coin::split<UCT>(arg0, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

