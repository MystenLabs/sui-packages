module 0x539947c43ccb7c46efd0c7a3af2260878291fc4df602eaebfd6a067563bf388c::lunacyzeus_coin {
    struct LUNACYZEUS_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LUNACYZEUS_COIN>, arg1: 0x2::coin::Coin<LUNACYZEUS_COIN>) {
        0x2::coin::burn<LUNACYZEUS_COIN>(arg0, arg1);
    }

    fun init(arg0: LUNACYZEUS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNACYZEUS_COIN>(arg0, 9, b"LUNACYZEUS", b"LUNACYZEUS_COIN", b"This is LunacyZeus Coin in move testnet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/20926865")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUNACYZEUS_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNACYZEUS_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUNACYZEUS_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LUNACYZEUS_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

