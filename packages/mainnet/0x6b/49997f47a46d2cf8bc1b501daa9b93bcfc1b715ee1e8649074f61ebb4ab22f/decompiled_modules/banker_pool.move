module 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::banker_pool {
    struct BankerPool<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        reserved: u64,
        total_shares: u128,
        lock_duration_ms: u64,
        max_utilization_bps: u64,
        premium_bps: u64,
    }

    struct BankerPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        shares: u128,
        locked_until_ms: u64,
    }

    struct BankerDeposit has copy, drop {
        pool_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        provider: address,
        assets: u64,
        shares_minted: u128,
        total_shares_after: u128,
        equity_after: u64,
        locked_until_ms: u64,
        position_id: 0x2::object::ID,
    }

    struct BankerRedeem has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        shares_burned: u128,
        assets_out: u64,
        total_shares_after: u128,
        equity_after: u64,
    }

    struct BankerRoundSettled has copy, drop {
        pool_id: 0x2::object::ID,
        tranche_leg: u64,
        delta: u64,
        gain: bool,
        reserved_after: u64,
        equity_after: u64,
    }

    public(friend) fun absorb_tranche<T0>(arg0: &mut BankerPool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = BankerRoundSettled{
            pool_id        : 0x2::object::id<BankerPool<T0>>(arg0),
            tranche_leg    : 0,
            delta          : 0x2::coin::value<T0>(&arg1),
            gain           : true,
            reserved_after : arg0.reserved,
            equity_after   : equity<T0>(arg0),
        };
        0x2::event::emit<BankerRoundSettled>(v0);
    }

    public fun assets_for_shares<T0>(arg0: &BankerPool<T0>, arg1: u128) : u64 {
        let v0 = mul_div_floor(arg1, (equity<T0>(arg0) as u128) + 1, arg0.total_shares + 1000);
        assert!(v0 <= 18446744073709551615, 609);
        (v0 as u64)
    }

    public entry fun create_banker_pool<T0>(arg0: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::AdminCap, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 10000, 611);
        assert!(arg4 <= 10000, 611);
        let v0 = BankerPool<T0>{
            id                  : 0x2::object::new(arg5),
            vault_id            : 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg1),
            balance             : 0x2::balance::zero<T0>(),
            reserved            : 0,
            total_shares        : 0,
            lock_duration_ms    : arg2,
            max_utilization_bps : arg3,
            premium_bps         : arg4,
        };
        0x2::transfer::share_object<BankerPool<T0>>(v0);
    }

    public entry fun deposit_as_banker<T0>(arg0: &mut BankerPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_inner<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<BankerPosition<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun deposit_inner<T0>(arg0: &mut BankerPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : BankerPosition<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 600);
        let v1 = mul_div_floor((v0 as u128), arg0.total_shares + 1000, (equity<T0>(arg0) as u128) + 1);
        assert!(v1 > 0, 605);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v1;
        let v2 = 0x2::clock::timestamp_ms(arg2) + arg0.lock_duration_ms;
        let v3 = BankerPosition<T0>{
            id              : 0x2::object::new(arg3),
            pool_id         : 0x2::object::id<BankerPool<T0>>(arg0),
            shares          : v1,
            locked_until_ms : v2,
        };
        let v4 = BankerDeposit{
            pool_id            : 0x2::object::id<BankerPool<T0>>(arg0),
            vault_id           : arg0.vault_id,
            provider           : 0x2::tx_context::sender(arg3),
            assets             : v0,
            shares_minted      : v1,
            total_shares_after : arg0.total_shares,
            equity_after       : equity<T0>(arg0),
            locked_until_ms    : v2,
            position_id        : 0x2::object::id<BankerPosition<T0>>(&v3),
        };
        0x2::event::emit<BankerDeposit>(v4);
        v3
    }

    public fun equity<T0>(arg0: &BankerPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun free<T0>(arg0: &BankerPool<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 > arg0.reserved) {
            v0 - arg0.reserved
        } else {
            0
        }
    }

    public fun lock_duration_ms<T0>(arg0: &BankerPool<T0>) : u64 {
        arg0.lock_duration_ms
    }

    public fun max_utilization_bps<T0>(arg0: &BankerPool<T0>) : u64 {
        arg0.max_utilization_bps
    }

    fun mul_div_floor(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 610);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 609);
        (v0 as u128)
    }

    public fun position_locked_until_ms<T0>(arg0: &BankerPosition<T0>) : u64 {
        arg0.locked_until_ms
    }

    public fun position_pool_id<T0>(arg0: &BankerPosition<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_shares<T0>(arg0: &BankerPosition<T0>) : u128 {
        arg0.shares
    }

    public fun premium_bps<T0>(arg0: &BankerPool<T0>) : u64 {
        arg0.premium_bps
    }

    public fun price_ray<T0>(arg0: &BankerPool<T0>, arg1: u64) : u128 {
        mul_div_floor((arg1 as u128) + 1, 1000000000, arg0.total_shares + 1000)
    }

    public fun pro_rata(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 610);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public entry fun redeem_banker_all<T0>(arg0: &mut BankerPool<T0>, arg1: BankerPosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1;
        let v1 = redeem_core<T0>(arg0, v0, arg1.shares, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg3));
        let BankerPosition {
            id              : v2,
            pool_id         : _,
            shares          : _,
            locked_until_ms : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    public entry fun redeem_banker_partial<T0>(arg0: &mut BankerPool<T0>, arg1: &mut BankerPosition<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_core<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun redeem_core<T0>(arg0: &mut BankerPool<T0>, arg1: &mut BankerPosition<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.pool_id == 0x2::object::id<BankerPool<T0>>(arg0), 602);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.locked_until_ms, 603);
        assert!(arg2 > 0 && arg2 <= arg1.shares, 604);
        let v0 = mul_div_floor(arg2, (equity<T0>(arg0) as u128) + 1, arg0.total_shares + 1000);
        assert!(v0 <= 18446744073709551615, 609);
        let v1 = (v0 as u64);
        assert!(v1 > 0, 606);
        assert!(free<T0>(arg0) >= v1, 607);
        arg0.total_shares = arg0.total_shares - arg2;
        arg1.shares = arg1.shares - arg2;
        let v2 = BankerRedeem{
            pool_id            : 0x2::object::id<BankerPool<T0>>(arg0),
            provider           : 0x2::tx_context::sender(arg4),
            shares_burned      : arg2,
            assets_out         : v1,
            total_shares_after : arg0.total_shares,
            equity_after       : equity<T0>(arg0),
        };
        0x2::event::emit<BankerRedeem>(v2);
        0x2::coin::take<T0>(&mut arg0.balance, v1, arg4)
    }

    public(friend) fun release_tranche<T0>(arg0: &mut BankerPool<T0>, arg1: u64) {
        assert!(arg0.reserved >= arg1, 600);
        arg0.reserved = arg0.reserved - arg1;
    }

    public(friend) fun reserve_tranche<T0>(arg0: &mut BankerPool<T0>, arg1: u64) {
        assert!(arg1 > 0, 600);
        assert!(free<T0>(arg0) >= arg1, 607);
        if (arg0.max_utilization_bps > 0) {
            assert!(arg0.reserved + arg1 <= (mul_div_floor((0x2::balance::value<T0>(&arg0.balance) as u128), (arg0.max_utilization_bps as u128), (10000 as u128)) as u64), 608);
        };
        arg0.reserved = arg0.reserved + arg1;
    }

    public fun reserved<T0>(arg0: &BankerPool<T0>) : u64 {
        arg0.reserved
    }

    public entry fun set_lock_duration_ms<T0>(arg0: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::AdminCap, arg1: &mut BankerPool<T0>, arg2: u64) {
        arg1.lock_duration_ms = arg2;
    }

    public entry fun set_max_utilization_bps<T0>(arg0: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::AdminCap, arg1: &mut BankerPool<T0>, arg2: u64) {
        assert!(arg2 <= 10000, 611);
        arg1.max_utilization_bps = arg2;
    }

    public entry fun set_premium_bps<T0>(arg0: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::AdminCap, arg1: &mut BankerPool<T0>, arg2: u64) {
        assert!(arg2 <= 10000, 611);
        arg1.premium_bps = arg2;
    }

    public fun split_reservation(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = if (arg0 < arg1) {
            arg0
        } else {
            arg1
        };
        (v0, arg0 - v0)
    }

    public(friend) fun take_tranche_payout<T0>(arg0: &mut BankerPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 607);
        let v0 = BankerRoundSettled{
            pool_id        : 0x2::object::id<BankerPool<T0>>(arg0),
            tranche_leg    : 0,
            delta          : arg1,
            gain           : false,
            reserved_after : arg0.reserved,
            equity_after   : equity<T0>(arg0),
        };
        0x2::event::emit<BankerRoundSettled>(v0);
        0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2)
    }

    public fun total_shares<T0>(arg0: &BankerPool<T0>) : u128 {
        arg0.total_shares
    }

    public fun vault_id<T0>(arg0: &BankerPool<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

