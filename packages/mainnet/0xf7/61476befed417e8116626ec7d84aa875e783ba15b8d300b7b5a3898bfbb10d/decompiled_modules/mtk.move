module 0xf761476befed417e8116626ec7d84aa875e783ba15b8d300b7b5a3898bfbb10d::mtk {
    struct MTK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MTK>, arg1: 0x2::coin::Coin<MTK>) {
        0x2::coin::burn<MTK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MTK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MTK>>(0x2::coin::mint<MTK>(arg0, arg1, arg3), arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<MTK>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MTK>>(arg0, arg1);
    }

    fun init(arg0: MTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTK>(arg0, 9, b"MTK", b"My Token", b"A custom token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

