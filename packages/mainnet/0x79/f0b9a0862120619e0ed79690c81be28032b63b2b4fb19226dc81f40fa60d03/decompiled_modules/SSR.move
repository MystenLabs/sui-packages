module 0x79f0b9a0862120619e0ed79690c81be28032b63b2b4fb19226dc81f40fa60d03::SSR {
    struct SSR has drop {
        dummy_field: bool,
    }

    struct SupplyConfig has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        owner: address,
    }

    struct ExtendedTreasuryCap has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SSR>,
        current_supply: u64,
        supply_config: SupplyConfig,
    }

    public entry fun burn(arg0: &mut ExtendedTreasuryCap, arg1: 0x2::coin::Coin<SSR>) {
        0x2::coin::burn<SSR>(&mut arg0.treasury_cap, arg1);
        arg0.current_supply = arg0.current_supply - 0x2::coin::value<SSR>(&arg1);
    }

    fun init(arg0: SSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SSR>(arg0, 9, b"SSR", b"Samurai Shodown R", x"2453535220697320612066756e6769626c6520746f6b656e207468617420636f6e6e6563747320766172696f757320696e2d67616d6520616e642065787465726e616c206163746976697469657320696e2053616d757261692053686f646f776e205220627920534e4b2e205468726f756768207468697320746f6b656e2c20706c61796572732063616e20656e68616e636520696e2d67616d652067726f77746820656c656d656e74732c20657870657269656e6365207265616c206173736574206f776e6572736869702c20616e64206576656e20706172746963697061746520696e207468652065636f73797374656de2809973206f7065726174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://innofile.blob.core.windows.net/inno/live/icon/SSR_token_logo.png")), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSR>>(v2);
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = SupplyConfig{
            id         : 0x2::object::new(arg1),
            max_supply : 1000000000000000000,
            owner      : v3,
        };
        let v5 = ExtendedTreasuryCap{
            id             : 0x2::object::new(arg1),
            treasury_cap   : v0,
            current_supply : 1000000000000000000,
            supply_config  : v4,
        };
        0x2::coin::mint_and_transfer<SSR>(&mut v5.treasury_cap, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SSR>>(v1, v3);
        0x2::transfer::public_transfer<ExtendedTreasuryCap>(v5, v3);
    }

    public entry fun mint(arg0: &mut ExtendedTreasuryCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.current_supply + arg1;
        assert!(v0 <= arg0.supply_config.max_supply, 1);
        0x2::coin::mint_and_transfer<SSR>(&mut arg0.treasury_cap, arg1, 0x2::tx_context::sender(arg2), arg2);
        arg0.current_supply = v0;
    }

    public entry fun update_max_supply(arg0: &mut ExtendedTreasuryCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.supply_config.owner, 2);
        arg0.supply_config.max_supply = arg1;
    }

    // decompiled from Move bytecode v6
}

