module 0xf2934269c7ae2bb784e05b76aefd29bd2b9b842a571dd864b88f9d7f2c8a9eaf::main_03c {
    struct MAIN_03C has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MAIN_03C>, arg1: 0x2::coin::Coin<MAIN_03C>) {
        0x2::coin::burn<MAIN_03C>(arg0, arg1);
    }

    fun init(arg0: MAIN_03C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN_03C>(arg0, 9, b"EMBER", b"Ember Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-6kw_a52AhD.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MAIN_03C>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIN_03C>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun perform(arg0: &mut 0x2::coin::TreasuryCap<MAIN_03C>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MAIN_03C> {
        0x2::coin::mint<MAIN_03C>(arg0, arg1, arg2)
    }

    public entry fun perform_to(arg0: &mut 0x2::coin::TreasuryCap<MAIN_03C>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAIN_03C>>(0x2::coin::mint<MAIN_03C>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

