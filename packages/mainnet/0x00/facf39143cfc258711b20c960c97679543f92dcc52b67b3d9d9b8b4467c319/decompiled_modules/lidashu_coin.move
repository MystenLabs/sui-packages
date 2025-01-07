module 0xfacf39143cfc258711b20c960c97679543f92dcc52b67b3d9d9b8b4467c319::lidashu_coin {
    struct LIDASHU_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIDASHU_COIN>, arg1: 0x2::coin::Coin<LIDASHU_COIN>) {
        0x2::coin::burn<LIDASHU_COIN>(arg0, arg1);
    }

    fun init(arg0: LIDASHU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIDASHU_COIN>(arg0, 6, b"LDS", b"LIDASHU move coin", b"first step in sui move", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIDASHU_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIDASHU_COIN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIDASHU_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIDASHU_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

