module 0x1966e4a6c3934b69d96ef037602ffb55c7bc088a376760c9abaee7d482156ec9::lunacyzeus_faucet_coin {
    struct LUNACYZEUS_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LUNACYZEUS_FAUCET_COIN>, arg1: 0x2::coin::Coin<LUNACYZEUS_FAUCET_COIN>) {
        0x2::coin::burn<LUNACYZEUS_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: LUNACYZEUS_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNACYZEUS_FAUCET_COIN>(arg0, 9, b"LUNA", b"LUNACYZEUS_FAUCET_COIN", b"LunacyZeus Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/20926865")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUNACYZEUS_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LUNACYZEUS_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUNACYZEUS_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LUNACYZEUS_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

