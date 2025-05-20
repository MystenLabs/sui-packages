module 0x498cfc67fcc54c3092747eb6b38acde56889c17a42ff4d67c3e1c1f83995f9d9::lock {
    struct LOCK has drop {
        dummy_field: bool,
    }

    struct LockOwnerCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct FunnifyLock<T0: store + key> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        coin: 0x2::coin::Coin<T0>,
        owner: address,
        lock_time: u64,
        start_time: u64,
        url: 0x2::url::Url,
    }

    struct Funnify has store, key {
        id: 0x2::object::UID,
        owner: address,
        tier: u8,
    }

    struct FunnifyStake has store, key {
        id: 0x2::object::UID,
        funnify: Funnify,
        start_time: u64,
    }

    struct LockCreated has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        owner: address,
        lock_time: u64,
    }

    struct LockUnlocked has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        owner: address,
        lock_time: u64,
    }

    struct Minted has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        tier: u8,
    }

    struct Staked has copy, drop {
        id: 0x2::object::ID,
        funnify: 0x2::object::ID,
        start_time: u64,
    }

    struct Unstaked has copy, drop {
        id: 0x2::object::ID,
        funnify: 0x2::object::ID,
    }

    struct Harvested has copy, drop {
        id: 0x2::object::ID,
        funnify: 0x2::object::ID,
        amount: u64,
    }

    struct LockStorage<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        supply: u64,
        total_locked: u64,
        total_staked: u64,
        common_lock: u64,
        reserve: 0x2::balance::Balance<T0>,
    }

    public fun lock<T0: store + key>(arg0: &mut LockStorage<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (Funnify, FunnifyLock<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        arg0.supply = arg0.supply + 1;
        arg0.total_locked = arg0.total_locked + v0;
        let v1 = 0x2::object::new(arg3);
        let v2 = FunnifyLock<T0>{
            id         : v1,
            amount     : 0x2::coin::value<T0>(&arg1),
            coin       : arg1,
            owner      : 0x2::tx_context::sender(arg3),
            lock_time  : 86400 * 3 * 1000,
            start_time : 0x2::clock::timestamp_ms(arg2),
            url        : 0x2::url::new_unsafe_from_bytes(b"https://92ba31ccd969233e49d859b38fd4603f.ipfscdn.io/ipfs/bafybeigb7f7qehyvyav5j67zup5ovnc5yd3kq35r64n2spe7vjex46xqwq/0"),
        };
        let v3 = LockCreated{
            id        : 0x2::object::uid_to_inner(&v1),
            amount    : v2.amount,
            owner     : v2.owner,
            lock_time : v2.lock_time,
        };
        0x2::event::emit<LockCreated>(v3);
        let v4 = 0x2::object::new(arg3);
        let v5 = Funnify{
            id    : v4,
            owner : 0x2::tx_context::sender(arg3),
            tier  : 0x498cfc67fcc54c3092747eb6b38acde56889c17a42ff4d67c3e1c1f83995f9d9::tier::compute_tier(v0),
        };
        let v6 = Minted{
            id    : 0x2::object::uid_to_inner(&v4),
            owner : v5.owner,
            tier  : v5.tier,
        };
        0x2::event::emit<Minted>(v6);
        (v5, v2)
    }

    public fun fund_reserve<T0: store + key>(arg0: &mut LockStorage<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun harvest<T0: store + key>(arg0: &mut LockStorage<T0>, arg1: &mut FunnifyStake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0 - arg1.start_time;
        assert!(v1 > 0, 1);
        let v2 = 0x498cfc67fcc54c3092747eb6b38acde56889c17a42ff4d67c3e1c1f83995f9d9::tier::compute_reward(arg1.funnify.tier, v1);
        arg1.start_time = v0;
        let v3 = Harvested{
            id      : 0x2::object::uid_to_inner(&arg1.id),
            funnify : 0x2::object::uid_to_inner(&arg1.funnify.id),
            amount  : v2,
        };
        0x2::event::emit<Harvested>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, v2), arg3)
    }

    fun init(arg0: LOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LOCK>(arg0, arg1), v0);
        let v1 = LockOwnerCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        };
        0x2::transfer::public_transfer<LockOwnerCap>(v1, v0);
    }

    public fun init_config<T0: store + key>(arg0: &mut LockOwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LockStorage<T0>{
            id           : 0x2::object::new(arg1),
            supply       : 0,
            total_locked : 0,
            total_staked : 0,
            common_lock  : 1000000000 * 1000,
            reserve      : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_share_object<LockStorage<T0>>(v0);
    }

    public fun stake<T0: store + key>(arg0: &mut LockStorage<T0>, arg1: Funnify, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : FunnifyStake {
        let v0 = 0x2::object::new(arg3);
        let v1 = FunnifyStake{
            id         : v0,
            funnify    : arg1,
            start_time : 0x2::clock::timestamp_ms(arg2),
        };
        arg0.total_staked = arg0.total_staked + 1;
        let v2 = Staked{
            id         : 0x2::object::uid_to_inner(&v0),
            funnify    : 0x2::object::uid_to_inner(&arg1.id),
            start_time : v1.start_time,
        };
        0x2::event::emit<Staked>(v2);
        v1
    }

    public fun unlock<T0: store + key>(arg0: &mut LockStorage<T0>, arg1: FunnifyLock<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let FunnifyLock {
            id         : v0,
            amount     : v1,
            coin       : v2,
            owner      : v3,
            lock_time  : v4,
            start_time : v5,
            url        : _,
        } = arg1;
        let v7 = v0;
        assert!(v3 == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::clock::timestamp_ms(arg2) - v5 >= v4, 2);
        arg0.total_locked = arg0.total_locked - v1;
        arg0.supply = arg0.supply - 1;
        0x2::object::delete(v7);
        let v8 = LockUnlocked{
            id        : 0x2::object::uid_to_inner(&v7),
            amount    : v1,
            owner     : v3,
            lock_time : v4,
        };
        0x2::event::emit<LockUnlocked>(v8);
        v2
    }

    public fun unstake<T0: store + key>(arg0: &mut LockStorage<T0>, arg1: FunnifyStake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (Funnify, 0x2::coin::Coin<T0>) {
        let FunnifyStake {
            id         : v0,
            funnify    : v1,
            start_time : v2,
        } = arg1;
        let v3 = v1;
        let v4 = v0;
        let v5 = 0x2::clock::timestamp_ms(arg2) - v2;
        assert!(v5 > 0, 1);
        arg0.total_staked = arg0.total_staked - 1;
        0x2::object::delete(v4);
        let v6 = Unstaked{
            id      : 0x2::object::uid_to_inner(&v4),
            funnify : 0x2::object::uid_to_inner(&v3.id),
        };
        0x2::event::emit<Unstaked>(v6);
        (v3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, 0x498cfc67fcc54c3092747eb6b38acde56889c17a42ff4d67c3e1c1f83995f9d9::tier::compute_reward(v3.tier, v5)), arg3))
    }

    // decompiled from Move bytecode v6
}

