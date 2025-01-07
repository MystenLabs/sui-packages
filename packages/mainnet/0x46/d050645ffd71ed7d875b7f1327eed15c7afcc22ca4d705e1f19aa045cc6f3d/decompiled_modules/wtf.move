module 0x46d050645ffd71ed7d875b7f1327eed15c7afcc22ca4d705e1f19aa045cc6f3d::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WTF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WTF>>(0x2::coin::mint<WTF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 6, b"WTF", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

