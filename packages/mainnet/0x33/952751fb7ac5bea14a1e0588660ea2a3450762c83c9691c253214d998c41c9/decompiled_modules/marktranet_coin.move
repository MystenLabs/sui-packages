module 0x33952751fb7ac5bea14a1e0588660ea2a3450762c83c9691c253214d998c41c9::marktranet_coin {
    struct MARKTRANET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MARKTRANET_COIN>, arg1: 0x2::coin::Coin<MARKTRANET_COIN>) {
        0x2::coin::burn<MARKTRANET_COIN>(arg0, arg1);
    }

    fun init(arg0: MARKTRANET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARKTRANET_COIN>(arg0, 9, b"MARKTRANET_COIN", b"marktranet's", b"first coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167279101")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARKTRANET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARKTRANET_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MARKTRANET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MARKTRANET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

