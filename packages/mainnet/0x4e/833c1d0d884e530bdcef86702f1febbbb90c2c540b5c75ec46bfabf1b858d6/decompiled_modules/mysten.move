module 0x4e833c1d0d884e530bdcef86702f1febbbb90c2c540b5c75ec46bfabf1b858d6::mysten {
    struct MYSTEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTEN>(arg0, 6, b"MYSTEN", b"Mysten Labs Token", b"This is a community token representing Mysten Labs. If Bitcoin will be the future \"store of value\" Mysten Lab's Sui will surely be what you use to buy groceries. When this sends will create another liquidity pool and burn the LP tokens. No socials. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732271294740.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYSTEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

