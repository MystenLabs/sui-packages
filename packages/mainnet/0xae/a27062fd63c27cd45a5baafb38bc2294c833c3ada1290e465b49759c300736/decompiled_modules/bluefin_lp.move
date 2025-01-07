module 0x757f654c6f2094287d5933ec381a828d4ac74e0a0723a1723647576ebf8bd2cb::bluefin_lp {
    struct BLUEFIN_LP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BeneficiaryCap has store, key {
        id: 0x2::object::UID,
    }

    struct BluefinLPTreasury has key {
        id: 0x2::object::UID,
        version: u64,
        cap: 0x2::coin::TreasuryCap<BLUEFIN_LP>,
    }

    struct BluefinLPVault has store, key {
        id: 0x2::object::UID,
        position: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position,
        target_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        target_sqrt_price: u128,
        a_normalizer: u64,
        b_normalizer: u64,
        bluefin_lp_supply: u64,
    }

    struct NewVault<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct DestroyVault<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        removal_a: u64,
        removal_b: u64,
    }

    struct CollectFee<phantom T0> has copy, drop {
        amount: u64,
    }

    struct CollectFeeFrom<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct Deposit<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        bluefin_lp_amount: u64,
    }

    struct Withdraw<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        bluefin_lp_amount: u64,
    }

    struct BalanceType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun burn(arg0: &mut BluefinLPTreasury, arg1: &mut BluefinLPVault, arg2: 0x2::coin::Coin<BLUEFIN_LP>) {
        let v0 = 0x2::coin::value<BLUEFIN_LP>(&arg2);
        assert!(v0 <= arg1.bluefin_lp_supply, 1);
        arg1.bluefin_lp_supply = arg1.bluefin_lp_supply - v0;
        0x2::coin::burn<BLUEFIN_LP>(&mut arg0.cap, arg2);
    }

    fun mint(arg0: &mut BluefinLPTreasury, arg1: &mut BluefinLPVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BLUEFIN_LP> {
        arg1.bluefin_lp_supply = arg1.bluefin_lp_supply + arg2;
        0x2::coin::mint<BLUEFIN_LP>(&mut arg0.cap, arg2, arg3)
    }

    fun collect_fee<T0>(arg0: &mut BluefinLPTreasury, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(borrow_balance_mut<T0>(arg0), arg2);
        let v0 = CollectFeeFrom<T0>{
            pool_id : arg1,
            amount  : 0x2::balance::value<T0>(&arg2),
        };
        0x2::event::emit<CollectFeeFrom<T0>>(v0);
    }

    fun assert_valid_package_version(arg0: &BluefinLPTreasury) {
        assert!(arg0.version == 2, 0);
    }

    fun borrow_balance_mut<T0>(arg0: &mut BluefinLPTreasury) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceType<T0>{dummy_field: false};
        let v1 = &mut arg0.id;
        if (!0x2::dynamic_field::exists_<BalanceType<T0>>(v1, v0)) {
            0x2::dynamic_field::add<BalanceType<T0>, 0x2::balance::Balance<T0>>(v1, v0, 0x2::balance::zero<T0>());
        };
        0x2::dynamic_field::borrow_mut<BalanceType<T0>, 0x2::balance::Balance<T0>>(v1, v0)
    }

    public fun borrow_bluefin_position(arg0: &BluefinLPVault) : &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        &arg0.position
    }

    public fun borrow_treasury_cap(arg0: &BluefinLPTreasury) : &0x2::coin::TreasuryCap<BLUEFIN_LP> {
        &arg0.cap
    }

    public fun claim_all<T0>(arg0: &BeneficiaryCap, arg1: &mut BluefinLPTreasury) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg1);
        0x2::balance::withdraw_all<T0>(borrow_balance_mut<T0>(arg1))
    }

    public fun claim_fee<T0>(arg0: &BeneficiaryCap, arg1: &mut BluefinLPTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(borrow_balance_mut<T0>(arg1), arg2), arg3)
    }

    public fun claim_fee_to<T0>(arg0: &BeneficiaryCap, arg1: &mut BluefinLPTreasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim_fee<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun claim_reward<T0, T1, T2>(arg0: &mut BluefinLPVault, arg1: &BeneficiaryCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg2, arg3, &mut arg0.position)
    }

    public fun claim_reward_to<T0, T1, T2>(arg0: &mut BluefinLPVault, arg1: &BeneficiaryCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(claim_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), arg6), arg5);
    }

    public fun create_vault<T0, T1>(arg0: &AdminCap, arg1: &BluefinLPTreasury, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u32, arg7: u128, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4)), 2);
        let v0 = BluefinLPVault{
            id                : 0x2::object::new(arg10),
            position          : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg10),
            target_tick       : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6),
            target_sqrt_price : arg7,
            a_normalizer      : arg8,
            b_normalizer      : arg9,
            bluefin_lp_supply : 0,
        };
        0x2::transfer::share_object<BluefinLPVault>(v0);
        let v1 = NewVault<T0, T1>{
            vault_id   : 0x2::object::id<BluefinLPVault>(&v0),
            pool_id    : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            tick_lower : arg4,
            tick_upper : arg5,
        };
        0x2::event::emit<NewVault<T0, T1>>(v1);
    }

    public fun deposit<T0, T1>(arg0: &mut BluefinLPTreasury, arg1: &mut BluefinLPVault, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<BLUEFIN_LP>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_valid_package_version(arg0);
        let (v0, v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg8, arg2, arg3, &mut arg1.position, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7);
        let v4 = liquidity_to_bluefin_lp_amount(arg1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg3) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg3));
        let v5 = mint(arg0, arg1, v4, arg9);
        let v6 = Deposit<T0, T1>{
            vault_id          : 0x2::object::id<BluefinLPVault>(arg1),
            amount_a          : v0,
            amount_b          : v1,
            bluefin_lp_amount : v4,
        };
        0x2::event::emit<Deposit<T0, T1>>(v6);
        (v5, v2, v3)
    }

    public fun destroy_vault<T0, T1>(arg0: &AdminCap, arg1: &BluefinLPTreasury, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: BluefinLPVault, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_valid_package_version(arg1);
        let BluefinLPVault {
            id                : v0,
            position          : v1,
            target_tick       : _,
            target_sqrt_price : _,
            a_normalizer      : _,
            b_normalizer      : _,
            bluefin_lp_supply : v6,
        } = arg4;
        let v7 = v1;
        let v8 = v0;
        assert!(v6 == 0, 3);
        0x2::object::delete(v8);
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v7);
        let (v10, v11, v12, v13) = if (v9 > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut v7, v9, arg5)
        } else {
            (0, 0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg5, arg2, arg3, v7);
        let v14 = DestroyVault<T0, T1>{
            vault_id  : 0x2::object::uid_to_inner(&v8),
            pool_id   : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            removal_a : v10,
            removal_b : v11,
        };
        0x2::event::emit<DestroyVault<T0, T1>>(v14);
        (v12, v13)
    }

    fun init(arg0: BLUEFIN_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEFIN_LP>(arg0, 9, b"BLUEFIN_LP", b"BLUEFIN-STABLE-LP", b"Fungible LP token for stable pair on Bluefin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/nfts/USDT-USDC.gif")), arg1);
        let v2 = BluefinLPTreasury{
            id      : 0x2::object::new(arg1),
            version : 2,
            cap     : v0,
        };
        0x2::transfer::share_object<BluefinLPTreasury>(v2);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEFIN_LP>>(v1, v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, v3);
        let v5 = BeneficiaryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BeneficiaryCap>(v5, v3);
    }

    public fun liquidity_to_bluefin_lp_amount(arg0: &BluefinLPVault, arg1: u128) : u64 {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&arg0.position), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&arg0.position), arg0.target_tick, arg0.target_sqrt_price, arg1, false);
        v0 * arg0.a_normalizer + v1 * arg0.b_normalizer
    }

    public fun update_version(arg0: &AdminCap, arg1: &mut BluefinLPTreasury, arg2: u64) {
        arg1.version = arg2;
    }

    public fun vault_supply(arg0: &BluefinLPVault) : u64 {
        arg0.bluefin_lp_supply
    }

    public fun withdraw<T0, T1>(arg0: &mut BluefinLPTreasury, arg1: &mut BluefinLPVault, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<BLUEFIN_LP>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_valid_package_version(arg0);
        let v0 = &mut arg1.position;
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg2, arg3, v0);
        let v5 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        collect_fee<T0>(arg0, v5, v3);
        collect_fee<T1>(arg0, v5, v4);
        let v6 = 0x2::coin::value<BLUEFIN_LP>(&arg5);
        let (v7, v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg3, v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v0), (v6 as u128), (arg1.bluefin_lp_supply as u128)), arg4);
        burn(arg0, arg1, arg5);
        let v11 = Withdraw<T0, T1>{
            vault_id          : 0x2::object::id<BluefinLPVault>(arg1),
            amount_a          : v7,
            amount_b          : v8,
            bluefin_lp_amount : v6,
        };
        0x2::event::emit<Withdraw<T0, T1>>(v11);
        (0x2::coin::from_balance<T0>(v9, arg6), 0x2::coin::from_balance<T1>(v10, arg6))
    }

    // decompiled from Move bytecode v6
}

