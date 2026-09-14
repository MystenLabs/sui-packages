module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::holder_yield {
    struct YieldHolder has drop, store {
        amount: u64,
        debt: u256,
        unpaid: u64,
    }

    struct HolderYieldVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        lock_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        holders: 0x2::table::Table<address, YieldHolder>,
        total_registered: u64,
        reward_pot: 0x2::balance::Balance<T1>,
        mps: u256,
    }

    fun accure(arg0: &mut YieldHolder, arg1: u256) {
        let v0 = (arg0.amount as u256) * arg1;
        if (v0 > arg0.debt) {
            arg0.unpaid = arg0.unpaid + u256_to_u64((v0 - arg0.debt) / 1000000000000);
        };
        arg0.debt = v0;
    }

    public fun assert_bound_to_lock<T0, T1>(arg0: &HolderYieldVault<T0, T1>, arg1: 0x2::object::ID) {
        assert!(arg0.lock_id == arg1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::wrong_yield());
    }

    public fun bluefin_pool_id<T0, T1>(arg0: &HolderYieldVault<T0, T1>) : 0x2::object::ID {
        arg0.bluefin_pool_id
    }

    public fun claim<T0, T1>(arg0: &mut HolderYieldVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, YieldHolder>(&arg0.holders, v0), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        let v1 = 0x2::table::borrow_mut<address, YieldHolder>(&mut arg0.holders, v0);
        accure(v1, arg0.mps);
        let v2 = v1.unpaid;
        v1.unpaid = 0;
        assert!(v2 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_holder_yield_claim(arg0.lock_id, 0x2::object::id<HolderYieldVault<T0, T1>>(arg0), v0, v2, 0x1::type_name::with_defining_ids<T1>());
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_pot, v2), arg1)
    }

    public(friend) fun create_and_share<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = HolderYieldVault<T0, T1>{
            id               : 0x2::object::new(arg2),
            lock_id          : arg0,
            bluefin_pool_id  : arg1,
            holders          : 0x2::table::new<address, YieldHolder>(arg2),
            total_registered : 0,
            reward_pot       : 0x2::balance::zero<T1>(),
            mps              : 0,
        };
        0x2::transfer::share_object<HolderYieldVault<T0, T1>>(v0);
        0x2::object::id<HolderYieldVault<T0, T1>>(&v0)
    }

    public(friend) fun create_vault_for_lock<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_and_share<T0, T1>(arg0, arg1, arg2)
    }

    fun ensure_holder<T0, T1>(arg0: &mut HolderYieldVault<T0, T1>, arg1: address) {
        if (!0x2::table::contains<address, YieldHolder>(&arg0.holders, arg1)) {
            let v0 = YieldHolder{
                amount : 0,
                debt   : 0,
                unpaid : 0,
            };
            0x2::table::add<address, YieldHolder>(&mut arg0.holders, arg1, v0);
        };
    }

    public fun holder_amount<T0, T1>(arg0: &HolderYieldVault<T0, T1>, arg1: address) : u64 {
        if (!0x2::table::contains<address, YieldHolder>(&arg0.holders, arg1)) {
            0
        } else {
            0x2::table::borrow<address, YieldHolder>(&arg0.holders, arg1).amount
        }
    }

    public fun lock_id<T0, T1>(arg0: &HolderYieldVault<T0, T1>) : 0x2::object::ID {
        arg0.lock_id
    }

    public fun mps<T0, T1>(arg0: &HolderYieldVault<T0, T1>) : u256 {
        arg0.mps
    }

    public fun pending<T0, T1>(arg0: &HolderYieldVault<T0, T1>, arg1: address) : u64 {
        if (!0x2::table::contains<address, YieldHolder>(&arg0.holders, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, YieldHolder>(&arg0.holders, arg1);
        let v1 = (v0.amount as u256) * arg0.mps;
        let v2 = if (v1 > v0.debt) {
            u256_to_u64((v1 - v0.debt) / 1000000000000)
        } else {
            0
        };
        v0.unpaid + v2
    }

    public fun reward_pot_value<T0, T1>(arg0: &HolderYieldVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.reward_pot)
    }

    public fun sync_registration<T0, T1>(arg0: &mut HolderYieldVault<T0, T1>, arg1: &0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(arg1);
        let v2 = arg0.mps;
        ensure_holder<T0, T1>(arg0, v0);
        let v3 = 0x2::table::borrow_mut<address, YieldHolder>(&mut arg0.holders, v0);
        accure(v3, v2);
        let v4 = v3.amount;
        if (v1 >= v4) {
            arg0.total_registered = arg0.total_registered + v1 - v4;
        } else {
            arg0.total_registered = arg0.total_registered - v4 - v1;
        };
        v3.amount = v1;
        v3.debt = (v1 as u256) * v2;
    }

    public fun total_registered<T0, T1>(arg0: &HolderYieldVault<T0, T1>) : u64 {
        arg0.total_registered
    }

    public(friend) fun try_fund<T0, T1>(arg0: &mut HolderYieldVault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 == 0 || arg0.total_registered == 0) {
            return arg1
        };
        arg0.mps = arg0.mps + (v0 as u256) * 1000000000000 / (arg0.total_registered as u256);
        0x2::balance::join<T1>(&mut arg0.reward_pot, arg1);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_holder_yield_funded(arg0.lock_id, 0x2::object::id<HolderYieldVault<T0, T1>>(arg0), arg0.bluefin_pool_id, 0x1::type_name::with_defining_ids<T1>(), v0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::zero<T1>()
    }

    fun u256_to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (arg0 as u64)
    }

    // decompiled from Move bytecode v7
}

