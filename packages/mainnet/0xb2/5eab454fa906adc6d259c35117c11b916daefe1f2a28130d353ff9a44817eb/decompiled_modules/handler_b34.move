module 0xb25eab454fa906adc6d259c35117c11b916daefe1f2a28130d353ff9a44817eb::handler_b34 {
    struct HANDLER_B34 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_B34>, arg1: 0x2::coin::Coin<HANDLER_B34>) {
        0x2::coin::burn<HANDLER_B34>(arg0, arg1);
    }

    public fun dispense(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_B34>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER_B34> {
        0x2::coin::mint<HANDLER_B34>(arg0, arg1, arg2)
    }

    public entry fun dispense_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_B34>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER_B34>>(0x2::coin::mint<HANDLER_B34>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HANDLER_B34, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER_B34>(arg0, 9, b"cUSD", b"Wrapped cUSD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-igxyUUMm3e.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER_B34>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER_B34>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

