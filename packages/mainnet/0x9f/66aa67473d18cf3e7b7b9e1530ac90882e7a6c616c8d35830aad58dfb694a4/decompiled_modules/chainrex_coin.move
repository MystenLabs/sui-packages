module 0x9f66aa67473d18cf3e7b7b9e1530ac90882e7a6c616c8d35830aad58dfb694a4::chainrex_coin {
    struct CHAINREX_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHAINREX_COIN>, arg1: 0x2::coin::Coin<CHAINREX_COIN>) {
        0x2::coin::burn<CHAINREX_COIN>(arg0, arg1);
    }

    fun init(arg0: CHAINREX_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAINREX_COIN>(arg0, 9, b"CHAINREX", b"CHAINREX_COIN", b"ChainRex Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/76983474")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAINREX_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAINREX_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHAINREX_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHAINREX_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

