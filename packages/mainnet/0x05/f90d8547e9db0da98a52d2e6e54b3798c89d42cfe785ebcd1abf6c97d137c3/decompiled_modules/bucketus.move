module 0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus {
    struct BUCKETUS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BeneficiaryCap has store, key {
        id: 0x2::object::UID,
    }

    struct BucketusTreasury has key {
        id: 0x2::object::UID,
        version: u64,
        cap: 0x2::coin::TreasuryCap<BUCKETUS>,
    }

    struct CetusLpVault has store, key {
        id: 0x2::object::UID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        target_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        target_sqrt_price: u128,
        a_normalizer: u64,
        b_normalizer: u64,
        bucketus_supply: u64,
    }

    struct NewVault<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct ClaimEvent<phantom T0> has copy, drop {
        amount: u64,
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
        bucketus_amount: u64,
    }

    struct Withdraw<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        bucketus_amount: u64,
    }

    struct BalanceType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun burn(arg0: &mut BucketusTreasury, arg1: &mut CetusLpVault, arg2: 0x2::coin::Coin<BUCKETUS>) {
        let v0 = 0x2::coin::value<BUCKETUS>(&arg2);
        assert!(v0 <= arg1.bucketus_supply, 1);
        arg1.bucketus_supply = arg1.bucketus_supply - v0;
        0x2::coin::burn<BUCKETUS>(&mut arg0.cap, arg2);
    }

    fun mint(arg0: &mut BucketusTreasury, arg1: &mut CetusLpVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BUCKETUS> {
        arg1.bucketus_supply = arg1.bucketus_supply + arg2;
        0x2::coin::mint<BUCKETUS>(&mut arg0.cap, arg2, arg3)
    }

    fun collect_fee<T0>(arg0: &mut BucketusTreasury, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(borrow_balance_mut<T0>(arg0), arg2);
        let v0 = CollectFeeFrom<T0>{
            pool_id : arg1,
            amount  : 0x2::balance::value<T0>(&arg2),
        };
        0x2::event::emit<CollectFeeFrom<T0>>(v0);
    }

    fun assert_valid_package_version(arg0: &BucketusTreasury) {
        assert!(arg0.version == 1, 0);
    }

    fun borrow_balance_mut<T0>(arg0: &mut BucketusTreasury) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceType<T0>{dummy_field: false};
        let v1 = &mut arg0.id;
        if (!0x2::dynamic_field::exists_<BalanceType<T0>>(v1, v0)) {
            0x2::dynamic_field::add<BalanceType<T0>, 0x2::balance::Balance<T0>>(v1, v0, 0x2::balance::zero<T0>());
        };
        0x2::dynamic_field::borrow_mut<BalanceType<T0>, 0x2::balance::Balance<T0>>(v1, v0)
    }

    public fun borrow_cetus_position(arg0: &CetusLpVault) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        &arg0.position
    }

    public fun borrow_treasury_cap(arg0: &BucketusTreasury) : &0x2::coin::TreasuryCap<BUCKETUS> {
        &arg0.cap
    }

    public fun claim_all<T0>(arg0: &BeneficiaryCap, arg1: &mut BucketusTreasury) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg1);
        0x2::balance::withdraw_all<T0>(borrow_balance_mut<T0>(arg1))
    }

    public fun claim_fee<T0>(arg0: &BeneficiaryCap, arg1: &mut BucketusTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg1);
        let v0 = 0x2::coin::take<T0>(borrow_balance_mut<T0>(arg1), arg2, arg3);
        emit_claim_event<T0>(0x2::coin::balance<T0>(&v0));
        v0
    }

    public fun claim_fee_to<T0>(arg0: &BeneficiaryCap, arg1: &mut BucketusTreasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim_fee<T0>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun claim_reward<T0, T1, T2>(arg0: &BeneficiaryCap, arg1: &CetusLpVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, &arg1.position, arg4, true, arg5);
        emit_claim_event<T2>(&v0);
        v0
    }

    public fun claim_reward_to<T0, T1, T2>(arg0: &BeneficiaryCap, arg1: &CetusLpVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(claim_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5), arg7), arg6);
    }

    public fun collect_fee_to_treasury<T0, T1>(arg0: &mut BucketusTreasury, arg1: &CetusLpVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, &arg1.position, true);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3);
        collect_fee<T0>(arg0, v2, v0);
        collect_fee<T1>(arg0, v2, v1);
    }

    public fun create_vault<T0, T1>(arg0: &AdminCap, arg1: &BucketusTreasury, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u32, arg7: u128, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4)), 2);
        let v0 = CetusLpVault{
            id                : 0x2::object::new(arg10),
            position          : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg10),
            target_tick       : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6),
            target_sqrt_price : arg7,
            a_normalizer      : arg8,
            b_normalizer      : arg9,
            bucketus_supply   : 0,
        };
        0x2::transfer::share_object<CetusLpVault>(v0);
        let v1 = NewVault<T0, T1>{
            vault_id   : 0x2::object::id<CetusLpVault>(&v0),
            pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            tick_lower : arg4,
            tick_upper : arg5,
        };
        0x2::event::emit<NewVault<T0, T1>>(v1);
    }

    public fun deposit<T0, T1>(arg0: &mut BucketusTreasury, arg1: &mut CetusLpVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<BUCKETUS>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>) {
        assert_valid_package_version(arg0);
        let v0 = liquidity_to_bucketus_amount(arg1, arg4);
        let v1 = mint(arg0, arg1, v0, arg6);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg2, arg3, &mut arg1.position, arg4, arg5);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v2);
        let v5 = Deposit<T0, T1>{
            vault_id        : 0x2::object::id<CetusLpVault>(arg1),
            amount_a        : v3,
            amount_b        : v4,
            bucketus_amount : v0,
        };
        0x2::event::emit<Deposit<T0, T1>>(v5);
        (v1, v2)
    }

    entry fun destroy_vault<T0, T1>(arg0: &AdminCap, arg1: CetusLpVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun destroy_vault_<T0, T1, T2>(arg0: &AdminCap, arg1: CetusLpVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let CetusLpVault {
            id                : v0,
            position          : v1,
            target_tick       : _,
            target_sqrt_price : _,
            a_normalizer      : _,
            b_normalizer      : _,
            bucketus_supply   : _,
        } = arg1;
        let v7 = v1;
        0x2::object::delete(v0);
        let v8 = 0x2::tx_context::sender(arg6);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, &v7, arg4, true, arg5), arg6), v8);
        if (v9 > 0) {
            let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut v7, v9, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg6), v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg6), v8);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, v7);
    }

    fun emit_claim_event<T0>(arg0: &0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 > 0) {
            let v1 = ClaimEvent<T0>{amount: v0};
            0x2::event::emit<ClaimEvent<T0>>(v1);
        };
    }

    fun init(arg0: BUCKETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKETUS>(arg0, 9, b"BUCKETUS", b"SCET-STABLE-LP", b"Fungible LP token for stable pair on Cetus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://vb6zxndns5przvi3gv7fgo7auzf4qqremta27t4cj2bfawnrmifq.arweave.net/qH2btG2XXxzVGzV-UzvgpkvIQiRkwa_Pgk6CUFmxYgs")), arg1);
        let v2 = BucketusTreasury{
            id      : 0x2::object::new(arg1),
            version : 1,
            cap     : v0,
        };
        0x2::transfer::share_object<BucketusTreasury>(v2);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUCKETUS>>(v1, v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, v3);
        let v5 = BeneficiaryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BeneficiaryCap>(v5, v3);
    }

    public fun liquidity_to_bucketus_amount(arg0: &CetusLpVault, arg1: u128) : u64 {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&arg0.position);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(v0, v1, arg0.target_tick, arg0.target_sqrt_price, arg1, false);
        v2 * arg0.a_normalizer + v3 * arg0.b_normalizer
    }

    public fun update_version(arg0: &AdminCap, arg1: &mut BucketusTreasury, arg2: u64) {
        assert_valid_package_version(arg1);
        arg1.version = arg2;
    }

    public fun vault_supply(arg0: &CetusLpVault) : u64 {
        arg0.bucketus_supply
    }

    public fun withdraw<T0, T1>(arg0: &mut BucketusTreasury, arg1: &mut CetusLpVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<BUCKETUS>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_valid_package_version(arg0);
        collect_fee_to_treasury<T0, T1>(arg0, arg1, arg2, arg3);
        let v0 = 0x2::coin::value<BUCKETUS>(&arg5);
        let v1 = &mut arg1.position;
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1), (v0 as u128), (arg1.bucketus_supply as u128)), arg4);
        let v4 = v3;
        let v5 = v2;
        burn(arg0, arg1, arg5);
        let v6 = Withdraw<T0, T1>{
            vault_id        : 0x2::object::id<CetusLpVault>(arg1),
            amount_a        : 0x2::balance::value<T0>(&v5),
            amount_b        : 0x2::balance::value<T1>(&v4),
            bucketus_amount : v0,
        };
        0x2::event::emit<Withdraw<T0, T1>>(v6);
        (0x2::coin::from_balance<T0>(v5, arg6), 0x2::coin::from_balance<T1>(v4, arg6))
    }

    // decompiled from Move bytecode v6
}

