module 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::yield_factory {
    struct YieldFactoryConfig has key {
        id: 0x2::object::UID,
        interest_fee_rate: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
        vault_bag: 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::balance_bag::BalanceBag,
    }

    struct ConfigInitEvent has copy, drop {
        interest_rate: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
    }

    struct ConfigUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        interest_rate: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
        expiry_divisor: u64,
        treasury: address,
    }

    struct WithdrawInterestEvent<phantom T0: drop> has copy, drop {
        amount: u64,
        treasury: address,
    }

    struct PYCreationEvent<phantom T0: drop> has copy, drop {
        expiry: u64,
    }

    struct MintPyEvent<phantom T0: drop> has copy, drop {
        py_id: 0x2::object::ID,
        share_in: u64,
        amount_pt: u64,
        amount_yt: u64,
        expiry: u64,
    }

    struct RedeemPyEvent<phantom T0: drop> has copy, drop {
        py_id: 0x2::object::ID,
        amount_pt: u64,
        amount_yt: u64,
        amount_to_redeem: u64,
        share_out: u64,
        expiry: u64,
    }

    struct FeeCollectedEvent<phantom T0: drop> has copy, drop {
        amount: u64,
        treasury: address,
    }

    struct InterestCollectEvent<phantom T0: drop> has copy, drop {
        py_id: 0x2::object::ID,
        amount: u64,
        receiver: address,
    }

    public fun mint_py<T0: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: 0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::PriceVoucher<T0>, arg3: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::PyPosition, arg4: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>, arg5: &mut YieldFactoryConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::expiry(arg3) > 0x2::clock::timestamp_ms(arg6), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::factory_invalid_expiry());
        assert!(0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>>(arg4) == 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::py_state_id(arg3), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::factory_invalid_py());
        let v0 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::get_price<T0>(arg2, arg7));
        mint_py_internal<T0>(arg1, v0, arg3, arg4, arg5, arg6, arg7)
    }

    public fun redeem_due_interest<T0: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::PyPosition, arg2: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>, arg3: 0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::PriceVoucher<T0>, arg4: &mut YieldFactoryConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>>(arg2) == 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::py_state_id(arg1), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::factory_invalid_py());
        let v0 = 0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::get_price<T0>(arg3, arg6);
        if (0x2::clock::timestamp_ms(arg5) >= 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::py_expiry(arg1)) {
            let v1 = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::set_post_expiry_data<T0>(arg4.interest_fee_rate, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(v0), arg2, arg5, arg6);
            deposit_to_vault<T0>(arg4, arg2, v1, arg6);
        };
        let v2 = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::update_user_interest<T0>(arg4.interest_fee_rate, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(v0), arg1, arg2, arg5, arg6);
        deposit_to_vault<T0>(arg4, arg2, v2, arg6);
        let v3 = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::redeem_due_interest<T0>(arg1, arg2, arg6);
        let v4 = InterestCollectEvent<T0>{
            py_id    : 0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::PyPosition>(arg1),
            amount   : 0x2::coin::value<T0>(&v3),
            receiver : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<InterestCollectEvent<T0>>(v4);
        v3
    }

    public fun create<T0: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyStore, arg2: &YieldFactoryConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(arg3 % arg2.expiry_divisor == 0 && arg3 > 0x2::clock::timestamp_ms(arg4), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::factory_invalid_expiry());
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::create_py<T0>(arg1, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg5);
        let v0 = PYCreationEvent<T0>{expiry: arg3};
        0x2::event::emit<PYCreationEvent<T0>>(v0);
    }

    public(friend) fun deposit_to_vault<T0: drop>(arg0: &mut YieldFactoryConfig, arg1: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>, arg2: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg3: &0x2::tx_context::TxContext) {
        if (!0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::balance_bag::contains<T0>(&arg0.vault_bag)) {
            0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::balance_bag::init_balance<T0>(&mut arg0.vault_bag);
        };
        if (0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::greater(arg2, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::zero())) {
            0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::balance_bag::join<T0>(&mut arg0.vault_bag, 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::split_sy_balance<T0>(arg1, arg2));
        };
    }

    public fun init_config(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: u128, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::admin_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::update_config_invalid_sender());
        let v0 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(arg2);
        assert!(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::less_or_equal(v0, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational(1, 5)), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::interest_fee_rate_too_high());
        assert!(arg3 > 0, 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::factory_zero_expiry_divisor());
        let v1 = YieldFactoryConfig{
            id                : 0x2::object::new(arg5),
            interest_fee_rate : v0,
            expiry_divisor    : arg3,
            treasury          : arg4,
            vault_bag         : 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::balance_bag::new(arg5),
        };
        let v2 = ConfigInitEvent{
            interest_rate  : v0,
            expiry_divisor : arg3,
            treasury       : arg4,
        };
        0x2::event::emit<ConfigInitEvent>(v2);
        0x2::transfer::share_object<YieldFactoryConfig>(v1);
    }

    public(friend) fun interest_fee_rate(arg0: &YieldFactoryConfig) : 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64 {
        arg0.interest_fee_rate
    }

    public(friend) fun mint_py_internal<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg2: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::PyPosition, arg3: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>, arg4: &mut YieldFactoryConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::truncate(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::sy::sy_to_asset(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::current_py_index<T0>(arg1, arg3, arg5), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(v0)));
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::join_sy<T0>(arg0, arg3);
        let v2 = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::update_user_interest<T0>(arg4.interest_fee_rate, arg1, arg2, arg3, arg5, arg6);
        deposit_to_vault<T0>(arg4, arg3, v2, arg6);
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::mint_py<T0>(v1, v1, arg2, arg3, arg5);
        let v3 = MintPyEvent<T0>{
            py_id     : 0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::PyPosition>(arg2),
            share_in  : v0,
            amount_pt : v1,
            amount_yt : v1,
            expiry    : 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::expiry(arg2),
        };
        0x2::event::emit<MintPyEvent<T0>>(v3);
        v1
    }

    public fun redeem_interest_for_treasury<T0: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &mut YieldFactoryConfig, arg2: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>, arg3: 0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::PriceVoucher<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::expiry<T0>(arg2) < 0x2::clock::timestamp_ms(arg4), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::factory_yc_not_expired());
        let (_, _, v2) = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::collect_interest<T0>(arg1.interest_fee_rate, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::get_price<T0>(arg3, arg5)), arg2, arg4, arg5);
        deposit_to_vault<T0>(arg1, arg2, v2, arg5);
    }

    public fun redeem_py<T0: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: u64, arg2: u64, arg3: 0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::PriceVoucher<T0>, arg4: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::PyPosition, arg5: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>, arg6: &mut YieldFactoryConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>>(arg5) == 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::py_state_id(arg4), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::factory_invalid_py());
        let v0 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(0xc54f324d292bb11de32ffa36d9253fabdf89ea2c14d92edfc00c828cd84e2371::oracle_voucher::get_price<T0>(arg3, arg8));
        let v1 = redeem_py_internal<T0>(arg1, arg2, v0, arg4, arg5, arg6, arg7, arg8);
        let (v2, v3) = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::py_amount(arg4);
        if (v2 == 0 && v3 == 0) {
            0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::burn(arg4);
        };
        v1
    }

    public(friend) fun redeem_py_internal<T0: drop>(arg0: u64, arg1: u64, arg2: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg3: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::PyPosition, arg4: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>, arg5: &mut YieldFactoryConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg6) >= 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::expiry(arg3);
        let v1 = if (v0) {
            let v2 = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::set_post_expiry_data<T0>(arg5.interest_fee_rate, arg2, arg4, arg6, arg7);
            deposit_to_vault<T0>(arg5, arg4, v2, arg7);
            arg1
        } else {
            0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::math64::min(arg1, arg0)
        };
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::burn_py<T0>(v1, 0, arg3, arg4, arg6);
        if (!v0) {
            let v3 = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::update_user_interest<T0>(arg5.interest_fee_rate, arg2, arg3, arg4, arg6, arg7);
            deposit_to_vault<T0>(arg5, arg4, v3, arg7);
            0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::burn_py<T0>(0, v1, arg3, arg4, arg6);
        };
        let v4 = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::sy::asset_to_sy(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::current_py_index<T0>(arg2, arg4, arg6), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(v1));
        let v5 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::zero();
        if (v0) {
            v5 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::sub(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::sy::asset_to_sy(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::first_py_index<T0>(arg4), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(v1)), v4);
        };
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::transfer_sy<T0>(arg5.treasury, arg4, v5, arg7);
        let v6 = RedeemPyEvent<T0>{
            py_id            : 0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::PyPosition>(arg3),
            amount_pt        : v1,
            amount_yt        : v1,
            amount_to_redeem : v1,
            share_out        : 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::truncate(v4),
            expiry           : 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py_position::expiry(arg3),
        };
        0x2::event::emit<RedeemPyEvent<T0>>(v6);
        let v7 = FeeCollectedEvent<T0>{
            amount   : 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::truncate(v5),
            treasury : arg5.treasury,
        };
        0x2::event::emit<FeeCollectedEvent<T0>>(v7);
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::split_sy<T0>(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::truncate(v4), arg4, arg7)
    }

    public fun refund_from_vault<T0: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg2: &mut YieldFactoryConfig, arg3: u64, arg4: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::PyState<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg1);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg0, 0x2::tx_context::sender(arg5), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::admin_role()), 0);
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::py::join_sy<T0>(0x2::coin::from_balance<T0>(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::balance_bag::split<T0>(&mut arg2.vault_bag, arg3), arg5), arg4);
    }

    public(friend) fun treasury(arg0: &YieldFactoryConfig) : address {
        arg0.treasury
    }

    public fun update_config(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &mut 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: &mut YieldFactoryConfig, arg3: u128, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg6), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::admin_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::update_config_invalid_sender());
        let v0 = 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_raw_value(arg3);
        assert!(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::less_or_equal(v0, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::create_from_rational(1, 5)), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::interest_fee_rate_too_high());
        assert!(arg4 > 0, 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::factory_zero_expiry_divisor());
        arg2.expiry_divisor = arg4;
        arg2.interest_fee_rate = v0;
        arg2.treasury = arg5;
        let v1 = ConfigUpdateEvent{
            id             : 0x2::object::uid_to_inner(&arg2.id),
            interest_rate  : v0,
            expiry_divisor : arg4,
            treasury       : arg5,
        };
        0x2::event::emit<ConfigUpdateEvent>(v1);
    }

    public fun withdraw_interest_for_treasury<T0: drop, T1: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &mut YieldFactoryConfig, arg2: u64, arg3: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::sy::State, arg4: &0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market_global::MarketFactoryConfig, arg5: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::sy::redeem<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::balance_bag::split<T1>(&mut arg1.vault_bag, arg2), arg5), arg3, arg5), 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market_global::get_treasury(arg4));
        let v0 = WithdrawInterestEvent<T1>{
            amount   : arg2,
            treasury : arg1.treasury,
        };
        0x2::event::emit<WithdrawInterestEvent<T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

