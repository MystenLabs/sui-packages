module 0x9fdde7d8453ad896dd8e266b2c01b5e56f7851153f816cd8c030b1e9288d9a46::deusd_app_token {
    struct DEUSD_APP_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEUSD_APP_TOKEN>, arg1: 0x2::coin::Coin<DEUSD_APP_TOKEN>) {
        0x2::coin::burn<DEUSD_APP_TOKEN>(arg0, arg1);
    }

    fun init(arg0: DEUSD_APP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEUSD_APP_TOKEN>(arg0, 18, b"DEUSDAPP", b"DeusdApp Token", b"My OFTApp Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEUSD_APP_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEUSD_APP_TOKEN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEUSD_APP_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEUSD_APP_TOKEN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

