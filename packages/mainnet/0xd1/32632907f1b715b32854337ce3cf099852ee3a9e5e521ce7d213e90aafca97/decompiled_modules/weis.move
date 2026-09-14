module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis {
    struct WEIS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WEIS>, arg1: 0x2::coin::Coin<WEIS>) : u64 {
        0x2::coin::burn<WEIS>(arg0, arg1)
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WEIS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WEIS>>(0x2::coin::mint<WEIS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WEIS, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun init_weis_token(arg0: WEIS, arg1: &0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<WEIS>, 0x2::coin::CoinMetadata<WEIS>, 0x2::coin::Coin<WEIS>) {
        abort 0
    }

    public fun mint_and_return_coin_dori(arg0: &mut 0x2::coin::TreasuryCap<WEIS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WEIS> {
        0x2::coin::mint<WEIS>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

