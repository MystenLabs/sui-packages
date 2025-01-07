module 0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin {
    struct SD_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SD_FAUCET_COIN>,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SD_FAUCET_COIN>, arg1: 0x2::coin::Coin<SD_FAUCET_COIN>) {
        0x2::coin::burn<SD_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: SD_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SD_FAUCET_COIN>(arg0, 9, b"SDF", b"SD_FAUCET_COIN", b"StarryDesert Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/86464159")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SD_FAUCET_COIN>>(v1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    public entry fun mint(arg0: &mut TreasuryCapHolder, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SD_FAUCET_COIN>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

