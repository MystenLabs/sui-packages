module 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::mint {
    struct MintCertificate<phantom T0> {
        total_value: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        assets_metadata: vector<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>,
    }

    struct IndexMinted has copy, drop {
        total_value: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        amount: u64,
        assets_metadata: vector<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>,
    }

    struct PreMinted has copy, drop {
        total_value: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        change_value: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        amount: u64,
    }

    struct MintDiscountBadge<phantom T0> has store, key {
        id: 0x2::object::UID,
        percentage: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        exp_ts_seconds: u64,
    }

    public fun open_mint_public<T0>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::open_mint_public<T0>(arg0);
        mint_internal<T0>(arg0, arg1, arg2, arg4)
    }

    public fun open_mint_whitelist_only<T0>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::open_mint_whitelist_only<T0>(arg0);
        mint_internal<T0>(arg0, arg1, arg2, arg4)
    }

    public fun mint<T0>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::assert_mint_is_public<T0>(arg0);
        mint_internal<T0>(arg0, arg1, arg2, arg3)
    }

    fun calculate_mint_output_internal<T0>(arg0: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::metadata<T0>(arg0);
        0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::div(arg1, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::price<T0>(v0, arg2)), 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::decimals<T0>(v0))
    }

    public fun check_allocation_coverage<T0>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: vector<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>, arg2: &0x2::clock::Clock, arg3: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap) : MintCertificate<T0> {
        let v0 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::desired_value(0x1::vector::borrow<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(&arg1, 0));
        let v1 = 0x1::vector::empty<0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal>();
        let v2 = 0x1::vector::empty<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>();
        0x1::vector::reverse<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(&mut arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(&arg1)) {
            let v4 = &mut v2;
            let v5 = 0x1::vector::pop_back<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(&mut arg1);
            assert!(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::eq(v0, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::desired_value(&v5)), 143);
            0x1::vector::push_back<0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal>(&mut v1, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::value(&v5));
            0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::destroy(v5);
            0x1::vector::push_back<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(v4, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::metadata(&v5));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(arg1);
        check_allocation_coverage_internal<T0>(arg0, v0, v1, arg2);
        MintCertificate<T0>{
            total_value     : v0,
            assets_metadata : v2,
        }
    }

    fun check_allocation_coverage_internal<T0>(arg0: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal, arg2: vector<0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal>, arg3: &0x2::clock::Clock) : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal {
        assert!(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::assets_count<T0>(arg0) == 0x1::vector::length<0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal>(&arg2), 9223373376884572159);
        assert!(0x2::clock::timestamp_ms(arg3) - 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::last_update<T0>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::metadata<T0>(arg0)) < 10, 9223373381179539455);
        let v0 = 0;
        let v1 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::zero();
        let v2 = 10000;
        while (v0 < 0x1::vector::length<0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal>(&arg2)) {
            v1 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::add(v1, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::div(*0x1::vector::borrow<0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal>(&arg2, v0), arg1));
            v0 = v0 + 1;
        };
        let v3 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(v1, 4);
        assert!(v3 >= v2, 141);
        0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(arg1, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_percentage(v3 - v2))
    }

    public fun claim_mint_certificate<T0>(arg0: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: vector<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>) : MintCertificate<T0> {
        let v0 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::zero();
        let v1 = 0x1::vector::empty<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>();
        0x1::vector::reverse<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(&mut arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(&arg1)) {
            let v3 = &mut v1;
            let v4 = 0x1::vector::pop_back<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(&mut arg1);
            let v5 = 0x2::object::id<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>>(arg0);
            assert!(0x2::object::id_to_address(&v5) == 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::index_id(&v4), 142);
            assert!(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::eq(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::desired_value(0x1::vector::borrow<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(&arg1, 0)), 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::desired_value(&v4)), 143);
            v0 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::add(v0, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::value(&v4));
            0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::destroy(v4);
            0x1::vector::push_back<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(v3, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::metadata(&v4));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt>(arg1);
        MintCertificate<T0>{
            total_value     : v0,
            assets_metadata : v1,
        }
    }

    fun deposit_internal<T0, T1>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2::tx_context::TxContext) : (0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt, 0x2::coin::Coin<T1>) {
        let v0 = *0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::metadata<T0>(arg0);
        let v1 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::asset_mut<T0, T1>(arg0, arg1);
        let (_, _) = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::refresh_asset_price_with_pyth<T0, T1>(v1, arg4, arg6, arg7);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::deposit<T0, T1>(&v0, v1, arg2, arg3, arg4, arg5, arg8)
    }

    public fun deposit_with_pyth<T0, T1>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2::tx_context::TxContext) : (0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt, 0x2::coin::Coin<T1>) {
        let v0 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::mint_fee<T0>(arg0);
        deposit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg7)
    }

    public fun deposit_with_pyth_with_discount<T0, T1>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg6: &MintDiscountBadge<T0>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2::tx_context::TxContext) : (0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::DepositReceipt, 0x2::coin::Coin<T1>) {
        assert!(arg6.exp_ts_seconds > 0x2::clock::timestamp_ms(arg4) / 1000, 144);
        let v0 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::mint_fee<T0>(arg0);
        deposit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::sub(v0, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v0, arg6.percentage)), arg5, arg7, arg8)
    }

    public fun mint_discount_badge<T0>(arg0: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : MintDiscountBadge<T0> {
        MintDiscountBadge<T0>{
            id             : 0x2::object::new(arg4),
            percentage     : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_percentage(arg3),
            exp_ts_seconds : arg2,
        }
    }

    fun mint_internal<T0>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let MintCertificate {
            total_value     : v0,
            assets_metadata : v1,
        } = arg1;
        let v2 = calculate_mint_output_internal<T0>(arg0, v0, arg2);
        let v3 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset_metadata_collector::new<T0>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::assets_count<T0>(arg0));
        let v4 = v1;
        0x1::vector::reverse<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(&v4)) {
            0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset_metadata_collector::add_asset_metadata<T0>(&mut v3, 0x1::vector::pop_back<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(&mut v4));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(v4);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::refresh_price<T0>(arg0, v3, arg2);
        let v6 = IndexMinted{
            total_value     : v0,
            amount          : v2,
            assets_metadata : v1,
        };
        0x2::event::emit<IndexMinted>(v6);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::mint_coin<T0>(arg0, v2, arg3)
    }

    public fun mint_whitelist<T0>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::whitelist::WhitelistCertificate<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::assert_mint_is_open<T0>(arg0);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::whitelist::assert_expiration<T0>(arg2, arg3);
        mint_internal<T0>(arg0, arg1, arg3, arg4)
    }

    fun pre_deposit_internal<T0, T1>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = *0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::metadata<T0>(arg0);
        let v1 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::asset_mut<T0, T1>(arg0, arg1);
        let (_, _) = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::refresh_asset_price_with_pyth<T0, T1>(v1, arg3, arg4, arg5);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::deposit::pre_deposit<T0, T1>(&v0, v1, arg2, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::mint_fee<T0>(arg0), arg3);
    }

    public fun pre_deposit_with_pyth<T0, T1>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        pre_deposit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun pre_mint<T0>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: vector<u64>, arg2: vector<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::metadata<T0>(arg0);
        let v1 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(arg3, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::price_decimals<T0>(v0));
        let v2 = 0;
        let v3 = 0x1::vector::empty<0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal>();
        0x1::vector::reverse<u64>(&mut arg1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg1)) {
            let v5 = 0x1::vector::borrow<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(&arg2, v2);
            v2 = v2 + 1;
            0x1::vector::push_back<0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal>(&mut v3, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(0x1::vector::pop_back<u64>(&mut arg1), 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::decimals(v5)), 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::price(v5, arg4)));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg1);
        let v6 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(calculate_mint_output_internal<T0>(arg0, v1, arg4), 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::decimals<T0>(v0));
        let v7 = PreMinted{
            total_value  : v1,
            change_value : check_allocation_coverage_internal<T0>(arg0, v1, v3, arg4),
            amount       : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::sub(v6, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v6, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::mint_fee<T0>(v0))), 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::decimals<T0>(v0)),
        };
        0x2::event::emit<PreMinted>(v7);
    }

    // decompiled from Move bytecode v6
}

