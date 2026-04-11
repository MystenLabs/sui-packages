module 0x2c5653668edefe2a782bf755e02bda56149e7b65b56f6245fb75b718941d2ec9::iusd {
    struct Minted has copy, drop {
        amount: u64,
        recipient: address,
        collateral_ratio_bps: u64,
    }

    struct Burned has copy, drop {
        amount: u64,
        burner: address,
    }

    struct RevenueReceived has copy, drop {
        source: vector<u8>,
        amount: u64,
    }

    struct CollateralUpdated has copy, drop {
        asset: vector<u8>,
        chain: vector<u8>,
        value_mist: u64,
        tranche: u8,
    }

    struct DWalletDeposited has copy, drop {
        dwallet_cap_id: address,
        owner: address,
    }

    struct RedeemRequested has copy, drop {
        amount: u64,
        redeemer: address,
        request_id: address,
    }

    struct IUSD has drop {
        dummy_field: bool,
    }

    struct CollateralRecord has drop, store {
        asset: vector<u8>,
        chain: vector<u8>,
        dwallet_cap_id: address,
        value_mist: u64,
        tranche: u8,
        updated_ms: u64,
    }

    struct RedeemRequest has key {
        id: 0x2::object::UID,
        amount: u64,
        redeemer: address,
        created_ms: u64,
        fulfilled: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        revenue: 0x2::balance::Balance<0x2::sui::SUI>,
        senior_value_mist: u64,
        junior_value_mist: u64,
        total_minted: u64,
        total_burned: u64,
        dwallet_count: u64,
        minter: address,
        oracle: address,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<IUSD>, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<IUSD> {
        assert!(0x2::tx_context::sender(arg4) == arg1.minter, 0);
        assert!(arg2 > 0, 2);
        let v0 = supply(arg1) + arg2;
        let v1 = arg1.senior_value_mist + arg1.junior_value_mist;
        assert!(v1 * 10000 >= v0 * 11000, 1);
        assert!(arg1.senior_value_mist * 10000 >= v0 * 10000, 5);
        arg1.total_minted = arg1.total_minted + arg2;
        let v2 = if (v0 > 0) {
            v1 * 10000 / v0
        } else {
            0
        };
        let v3 = Minted{
            amount               : arg2,
            recipient            : arg3,
            collateral_ratio_bps : v2,
        };
        0x2::event::emit<Minted>(v3);
        0x2::coin::mint<IUSD>(arg0, arg2, arg4)
    }

    entry fun burn_and_redeem(arg0: &mut 0x2::coin::TreasuryCap<IUSD>, arg1: &mut Treasury, arg2: 0x2::coin::Coin<IUSD>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<IUSD>(&arg2);
        assert!(v0 > 0, 2);
        arg1.total_burned = arg1.total_burned + v0;
        let v1 = RedeemRequest{
            id         : 0x2::object::new(arg4),
            amount     : v0,
            redeemer   : 0x2::tx_context::sender(arg4),
            created_ms : 0x2::clock::timestamp_ms(arg3),
            fulfilled  : false,
        };
        let v2 = 0x2::object::id<RedeemRequest>(&v1);
        let v3 = Burned{
            amount : v0,
            burner : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Burned>(v3);
        let v4 = RedeemRequested{
            amount     : v0,
            redeemer   : 0x2::tx_context::sender(arg4),
            request_id : 0x2::object::id_to_address(&v2),
        };
        0x2::event::emit<RedeemRequested>(v4);
        0x2::coin::burn<IUSD>(arg0, arg2);
        0x2::transfer::transfer<RedeemRequest>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun collateral_ratio_bps(arg0: &Treasury) : u64 {
        let v0 = supply(arg0);
        if (v0 == 0) {
            return 0
        };
        (arg0.senior_value_mist + arg0.junior_value_mist) * 10000 / v0
    }

    entry fun deposit_dwallet_cap(arg0: &mut Treasury, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.minter, 0);
        let v0 = 0x2::object::id_to_address(&arg1);
        let v1 = arg0.dwallet_count;
        0x2::dynamic_field::add<u64, address>(&mut arg0.id, v1, v0);
        arg0.dwallet_count = v1 + 1;
        let v2 = DWalletDeposited{
            dwallet_cap_id : v0,
            owner          : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DWalletDeposited>(v2);
    }

    entry fun deposit_revenue(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.revenue, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = RevenueReceived{
            source : arg2,
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<RevenueReceived>(v0);
    }

    public fun dwallet_count(arg0: &Treasury) : u64 {
        arg0.dwallet_count
    }

    fun init(arg0: IUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUSD>(arg0, 9, b"iUSD", b"iUSD", b"Yield-bearing stable backed by gold, silver, equities, energy, and dollar instruments across Bitcoin, Ethereum, Solana, and Sui via IKA dWallet threshold signatures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui.ski/assets/iusd.svg")), arg1);
        let v2 = Treasury{
            id                : 0x2::object::new(arg1),
            revenue           : 0x2::balance::zero<0x2::sui::SUI>(),
            senior_value_mist : 0,
            junior_value_mist : 0,
            total_minted      : 0,
            total_burned      : 0,
            dwallet_count     : 0,
            minter            : 0x2::tx_context::sender(arg1),
            oracle            : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Treasury>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUSD>>(v1);
    }

    public fun junior_value(arg0: &Treasury) : u64 {
        arg0.junior_value_mist
    }

    entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<IUSD>, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IUSD>>(mint(arg0, arg1, arg2, arg3, arg4), arg3);
    }

    public fun revenue_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.revenue)
    }

    public fun senior_value(arg0: &Treasury) : u64 {
        arg0.senior_value_mist
    }

    entry fun set_minter(arg0: &mut Treasury, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.minter, 0);
        arg0.minter = arg1;
    }

    entry fun set_oracle(arg0: &mut Treasury, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.oracle, 0);
        arg0.oracle = arg1;
    }

    public fun supply(arg0: &Treasury) : u64 {
        arg0.total_minted - arg0.total_burned
    }

    public fun total_collateral(arg0: &Treasury) : u64 {
        arg0.senior_value_mist + arg0.junior_value_mist
    }

    entry fun update_collateral(arg0: &mut Treasury, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.oracle, 0);
        assert!(arg5 == 0 || arg5 == 1, 3);
        if (arg3 != @0x0) {
            let v0 = false;
            let v1 = 0;
            while (v1 < arg0.dwallet_count) {
                if (0x2::dynamic_field::exists_<u64>(&arg0.id, v1)) {
                    if (*0x2::dynamic_field::borrow<u64, address>(&arg0.id, v1) == arg3) {
                        v0 = true;
                    };
                };
                v1 = v1 + 1;
            };
            assert!(v0, 4);
        };
        let v2 = CollateralRecord{
            asset          : arg1,
            chain          : arg2,
            dwallet_cap_id : arg3,
            value_mist     : arg4,
            tranche        : arg5,
            updated_ms     : 0x2::clock::timestamp_ms(arg6),
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            let v3 = 0x2::dynamic_field::borrow<vector<u8>, CollateralRecord>(&arg0.id, arg1);
            if (v3.tranche == 0) {
                arg0.senior_value_mist = arg0.senior_value_mist - v3.value_mist;
            } else {
                arg0.junior_value_mist = arg0.junior_value_mist - v3.value_mist;
            };
            0x2::dynamic_field::remove<vector<u8>, CollateralRecord>(&mut arg0.id, arg1);
        };
        if (arg5 == 0) {
            arg0.senior_value_mist = arg0.senior_value_mist + arg4;
        } else {
            arg0.junior_value_mist = arg0.junior_value_mist + arg4;
        };
        0x2::dynamic_field::add<vector<u8>, CollateralRecord>(&mut arg0.id, arg1, v2);
        let v4 = CollateralUpdated{
            asset      : arg1,
            chain      : arg2,
            value_mist : arg4,
            tranche    : arg5,
        };
        0x2::event::emit<CollateralUpdated>(v4);
    }

    // decompiled from Move bytecode v7
}

