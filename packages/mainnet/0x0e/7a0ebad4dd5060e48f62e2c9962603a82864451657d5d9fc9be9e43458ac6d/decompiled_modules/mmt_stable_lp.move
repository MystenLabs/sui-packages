module 0x375e22e22157b643553d4e327ccf59fa8149605b90ab81c3645261f8e21bc879::mmt_stable_lp {
    struct MMT_STABLE_LP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BeneficiaryCap has store, key {
        id: 0x2::object::UID,
    }

    struct MmtLpTreasury has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        cap: 0x2::coin::TreasuryCap<MMT_STABLE_LP>,
    }

    struct MmtLpVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position,
        target_tick: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        target_sqrt_price: u128,
        a_normalizer: u64,
        b_normalizer: u64,
        mmt_lp_supply: u64,
    }

    struct NewVault<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        tick_upper: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
    }

    struct DestroyVault<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        removal_a: u64,
        removal_b: u64,
    }

    struct CollectFeeFrom<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct Deposit<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        mmt_lp_amount: u64,
    }

    struct Withdraw<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        mmt_lp_amount: u64,
    }

    struct BalanceType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun burn<T0, T1>(arg0: &mut MmtLpTreasury, arg1: &mut MmtLpVault<T0, T1>, arg2: 0x2::coin::Coin<MMT_STABLE_LP>) {
        let v0 = 0x2::coin::value<MMT_STABLE_LP>(&arg2);
        assert!(v0 <= arg1.mmt_lp_supply, 1);
        arg1.mmt_lp_supply = arg1.mmt_lp_supply - v0;
        0x2::coin::burn<MMT_STABLE_LP>(&mut arg0.cap, arg2);
    }

    fun mint<T0, T1>(arg0: &mut MmtLpTreasury, arg1: &mut MmtLpVault<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MMT_STABLE_LP> {
        arg1.mmt_lp_supply = arg1.mmt_lp_supply + arg2;
        0x2::coin::mint<MMT_STABLE_LP>(&mut arg0.cap, arg2, arg3)
    }

    public fun a_normalizer<T0, T1>(arg0: &MmtLpVault<T0, T1>) : u64 {
        arg0.a_normalizer
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut MmtLpTreasury, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.versions, arg2);
    }

    fun assert_valid_package_version(arg0: &MmtLpTreasury) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 0);
    }

    public fun b_normalizer<T0, T1>(arg0: &MmtLpVault<T0, T1>) : u64 {
        arg0.b_normalizer
    }

    fun borrow_balance_mut<T0>(arg0: &mut MmtLpTreasury) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceType<T0>{dummy_field: false};
        let v1 = &mut arg0.id;
        if (!0x2::dynamic_field::exists_<BalanceType<T0>>(v1, v0)) {
            0x2::dynamic_field::add<BalanceType<T0>, 0x2::balance::Balance<T0>>(v1, v0, 0x2::balance::zero<T0>());
        };
        0x2::dynamic_field::borrow_mut<BalanceType<T0>, 0x2::balance::Balance<T0>>(v1, v0)
    }

    public fun borrow_position<T0, T1>(arg0: &MmtLpVault<T0, T1>) : &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position {
        &arg0.position
    }

    public fun borrow_treasury_cap(arg0: &AdminCap, arg1: &MmtLpTreasury) : &0x2::coin::TreasuryCap<MMT_STABLE_LP> {
        &arg1.cap
    }

    public fun claim_fee<T0>(arg0: &BeneficiaryCap, arg1: &mut MmtLpTreasury, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg1);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(borrow_balance_mut<T0>(arg1)), arg2)
    }

    public fun claim_fee_to<T0>(arg0: &BeneficiaryCap, arg1: &mut MmtLpTreasury, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim_fee<T0>(arg0, arg1, arg3), arg2);
    }

    public fun claim_reward<T0, T1, T2>(arg0: &BeneficiaryCap, arg1: &mut MmtLpVault<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg3, &mut arg1.position, arg4, arg2, arg5)
    }

    public fun claim_reward_to<T0, T1, T2>(arg0: &BeneficiaryCap, arg1: &mut MmtLpVault<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(claim_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    fun collect_fee<T0>(arg0: &mut MmtLpTreasury, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(borrow_balance_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg2));
        let v0 = CollectFeeFrom<T0>{
            pool_id : arg1,
            amount  : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<CollectFeeFrom<T0>>(v0);
    }

    public fun create_vault<T0, T1>(arg0: &AdminCap, arg1: &MmtLpTreasury, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u32, arg7: u128, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg1);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg4);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg5);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gt(v1, v0), 2);
        let v2 = MmtLpVault<T0, T1>{
            id                : 0x2::object::new(arg10),
            position          : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg3, v0, v1, arg2, arg10),
            target_tick       : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg6),
            target_sqrt_price : arg7,
            a_normalizer      : arg8,
            b_normalizer      : arg9,
            mmt_lp_supply     : 0,
        };
        0x2::transfer::share_object<MmtLpVault<T0, T1>>(v2);
        let v3 = NewVault<T0, T1>{
            vault_id   : 0x2::object::id<MmtLpVault<T0, T1>>(&v2),
            pool_id    : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg3),
            tick_lower : v0,
            tick_upper : v1,
        };
        0x2::event::emit<NewVault<T0, T1>>(v3);
    }

    public fun deposit<T0, T1>(arg0: &mut MmtLpTreasury, arg1: &mut MmtLpVault<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<MMT_STABLE_LP>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_valid_package_version(arg0);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg3, &mut arg1.position, arg4, arg5, 0, 0, arg6, arg2, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = liquidity_to_mmt_lp_amount<T0, T1>(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg3) - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg3));
        let v5 = mint<T0, T1>(arg0, arg1, v4, arg7);
        let v6 = Deposit<T0, T1>{
            vault_id      : 0x2::object::id<MmtLpVault<T0, T1>>(arg1),
            amount_a      : 0x2::coin::value<T0>(&arg4) - 0x2::coin::value<T0>(&v3),
            amount_b      : 0x2::coin::value<T0>(&arg4) - 0x2::coin::value<T1>(&v2),
            mmt_lp_amount : v4,
        };
        0x2::event::emit<Deposit<T0, T1>>(v6);
        (v5, v3, v2)
    }

    public fun destroy_vault<T0, T1>(arg0: &AdminCap, arg1: &MmtLpTreasury, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: MmtLpVault<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_valid_package_version(arg1);
        let MmtLpVault {
            id                : v0,
            position          : v1,
            target_tick       : _,
            target_sqrt_price : _,
            a_normalizer      : _,
            b_normalizer      : _,
            mmt_lp_supply     : v6,
        } = arg4;
        let v7 = v1;
        let v8 = v0;
        assert!(v6 == 0, 3);
        0x2::object::delete(v8);
        let v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&v7);
        let (v10, v11) = if (v9 > 0) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg3, &mut v7, v9, 0, 0, arg5, arg2, arg6)
        } else {
            (0x2::coin::zero<T0>(arg6), 0x2::coin::zero<T1>(arg6))
        };
        let v12 = v11;
        let v13 = v10;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(v7, arg2, arg6);
        let v14 = DestroyVault<T0, T1>{
            vault_id  : 0x2::object::uid_to_inner(&v8),
            pool_id   : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg3),
            removal_a : 0x2::coin::value<T0>(&v13),
            removal_b : 0x2::coin::value<T1>(&v12),
        };
        0x2::event::emit<DestroyVault<T0, T1>>(v14);
        (v13, v12)
    }

    fun init(arg0: MMT_STABLE_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT_STABLE_LP>(arg0, 9, b"MMT_STABLE_LP", b"Momentum Stable LP", b"Fungible LP token for stable pair on Momentum", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = MmtLpTreasury{
            id       : 0x2::object::new(arg1),
            versions : 0x2::vec_set::singleton<u64>(package_version()),
            cap      : v0,
        };
        0x2::transfer::share_object<MmtLpTreasury>(v2);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMT_STABLE_LP>>(v1, v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, v3);
        let v5 = BeneficiaryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BeneficiaryCap>(v5, v3);
    }

    public fun liquidity_to_mmt_lp_amount<T0, T1>(arg0: &MmtLpVault<T0, T1>, arg1: u128) : u64 {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(arg0.target_sqrt_price, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(&arg0.position)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(&arg0.position)), arg1, false);
        v0 * arg0.a_normalizer + v1 * arg0.b_normalizer
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut MmtLpTreasury, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.versions, &arg2);
    }

    public fun vault_supply<T0, T1>(arg0: &MmtLpVault<T0, T1>) : u64 {
        arg0.mmt_lp_supply
    }

    public fun withdraw<T0, T1>(arg0: &mut MmtLpTreasury, arg1: &mut MmtLpVault<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<MMT_STABLE_LP>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_valid_package_version(arg0);
        let v0 = &mut arg1.position;
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg3, v0, arg4, arg2, arg6);
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg3);
        collect_fee<T0>(arg0, v3, v1);
        collect_fee<T1>(arg0, v3, v2);
        let v4 = 0x2::coin::value<MMT_STABLE_LP>(&arg5);
        let (v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg3, v0, (((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(v0) as u256) * (v4 as u256) / (arg1.mmt_lp_supply as u256)) as u128), 0, 0, arg4, arg2, arg6);
        let v7 = v6;
        let v8 = v5;
        burn<T0, T1>(arg0, arg1, arg5);
        let v9 = Withdraw<T0, T1>{
            vault_id      : 0x2::object::id<MmtLpVault<T0, T1>>(arg1),
            amount_a      : 0x2::coin::value<T0>(&v8),
            amount_b      : 0x2::coin::value<T1>(&v7),
            mmt_lp_amount : v4,
        };
        0x2::event::emit<Withdraw<T0, T1>>(v9);
        (v8, v7)
    }

    // decompiled from Move bytecode v6
}

