module 0x522255fd30868201eb396ab15dc96b897baace87ebef40d84c241893bb760e1c::Phigrosx_coin {
    struct PHIGROSX_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PHIGROSX_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PHIGROSX_COIN>>(0x2::coin::mint<PHIGROSX_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PHIGROSX_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<PHIGROSX_COIN>(arg0, 8, b"PC", b"PhigrosX Coin", b"the managed coin for test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHIGROSX_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<PHIGROSX_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHIGROSX_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

