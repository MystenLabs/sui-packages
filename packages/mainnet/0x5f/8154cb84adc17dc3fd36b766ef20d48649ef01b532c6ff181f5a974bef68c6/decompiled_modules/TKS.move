module 0x5f8154cb84adc17dc3fd36b766ef20d48649ef01b532c6ff181f5a974bef68c6::TKS {
    struct TKS has drop {
        dummy_field: bool,
    }

    struct SupplyConfig has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        owner: address,
    }

    struct ExtendedTreasuryCap has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TKS>,
        current_supply: u64,
        supply_config: SupplyConfig,
    }

    public entry fun burn(arg0: &mut ExtendedTreasuryCap, arg1: 0x2::coin::Coin<TKS>) {
        0x2::coin::burn<TKS>(&mut arg0.treasury_cap, arg1);
        arg0.current_supply = arg0.current_supply - 0x2::coin::value<TKS>(&arg1);
    }

    fun init(arg0: TKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TKS>(arg0, 9, b"TKS", b"im Tonkatsu", b"$TKS is a fungible token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/1714187360/ko/%EB%B2%A1%ED%84%B0/%EC%B9%98%ED%82%A8-%EB%82%9C%EB%B0%98-%EB%98%90%EB%8A%94-%EC%B9%98%ED%82%A8-%EC%B9%B4%EC%B8%A0.jpg?s=612x612&w=0&k=20&c=bHKAPM7FZOi1rWfexjA7RXiqKuDqt1DOui2JIu2rA7k=")), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKS>>(v2);
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
        0x2::coin::mint_and_transfer<TKS>(&mut v5.treasury_cap, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TKS>>(v1, v3);
        0x2::transfer::public_transfer<ExtendedTreasuryCap>(v5, v3);
    }

    public entry fun mint(arg0: &mut ExtendedTreasuryCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.current_supply + arg1;
        assert!(v0 <= arg0.supply_config.max_supply, 1);
        0x2::coin::mint_and_transfer<TKS>(&mut arg0.treasury_cap, arg1, 0x2::tx_context::sender(arg2), arg2);
        arg0.current_supply = v0;
    }

    public entry fun update_max_supply(arg0: &mut ExtendedTreasuryCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.supply_config.owner, 2);
        arg0.supply_config.max_supply = arg1;
    }

    // decompiled from Move bytecode v6
}

