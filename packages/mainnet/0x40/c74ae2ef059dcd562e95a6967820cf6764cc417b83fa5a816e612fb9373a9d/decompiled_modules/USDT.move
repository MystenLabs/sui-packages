module 0x40c74ae2ef059dcd562e95a6967820cf6764cc417b83fa5a816e612fb9373a9d::USDT {
    struct USDT has drop {
        dummy_field: bool,
    }

    public entry fun admin_transfer(arg0: 0x2::coin::TreasuryCap<USDT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(arg0, arg1);
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"Tether USD", b"Tether USD on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_usdt(arg0: &mut 0x2::coin::Coin<USDT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::split<USDT>(arg0, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

