module 0x2d8578fb495fb162a4ebb3b874febdb73a03366716f79c2ced058860d8abeeda::wbtc_app_token {
    struct WBTC_APP_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTC_APP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTC_APP_TOKEN>(arg0, 8, b"WBTCAPP", b"WbtcApp Token", b"My OFTApp Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTC_APP_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBTC_APP_TOKEN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WBTC_APP_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WBTC_APP_TOKEN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

