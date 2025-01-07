module 0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin {
    struct CHAINREX_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<CHAINREX_FAUCET_COIN>,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHAINREX_FAUCET_COIN>, arg1: 0x2::coin::Coin<CHAINREX_FAUCET_COIN>) {
        0x2::coin::burn<CHAINREX_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: CHAINREX_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAINREX_FAUCET_COIN>(arg0, 9, b"CRF", b"CHAINREX_FAUCET_COIN", b"ChainRex Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/76983474")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAINREX_FAUCET_COIN>>(v1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    public entry fun mint(arg0: &mut TreasuryCapHolder, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHAINREX_FAUCET_COIN>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

