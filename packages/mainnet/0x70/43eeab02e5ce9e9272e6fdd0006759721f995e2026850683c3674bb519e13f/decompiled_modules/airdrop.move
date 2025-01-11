module 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::airdrop {
    struct NewAirdropPool<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
        total_supply: u64,
    }

    struct DestroyAirdropPool<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        surplus: u64,
    }

    struct NewEligibility<phantom T0, phantom T1> has copy, drop {
        id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct Claim<phantom T0, phantom T1> has copy, drop {
        id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct AirdropPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        total_allocated: u64,
        balance: 0x2::balance::Balance<T0>,
        start_time: u64,
        end_time: u64,
        managers: 0x2::vec_set::VecSet<address>,
    }

    struct Eligibility has store, key {
        id: 0x2::object::UID,
        amount: u64,
        pool_id: 0x2::object::ID,
    }

    public fun balance<T0, T1>(arg0: &AirdropPool<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun new<T0, T1>(arg0: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : AirdropPool<T0, T1> {
        let v0 = arg3 > arg2 && arg2 > 0x2::clock::timestamp_ms(arg1);
        if (!v0) {
            err_invalid_time_settings();
        };
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::coin::value<T0>(&arg4);
        let v3 = NewAirdropPool<T0, T1>{
            pool_id      : 0x2::object::uid_to_inner(&v1),
            start_time   : arg2,
            end_time     : arg3,
            total_supply : v2,
        };
        0x2::event::emit<NewAirdropPool<T0, T1>>(v3);
        AirdropPool<T0, T1>{
            id              : v1,
            total_supply    : v2,
            total_allocated : 0,
            balance         : 0x2::coin::into_balance<T0>(arg4),
            start_time      : arg2,
            end_time        : arg3,
            managers        : 0x2::vec_set::empty<address>(),
        }
    }

    public fun add_manager<T0, T1>(arg0: &mut AirdropPool<T0, T1>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T1>, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun allocate<T0, T1>(arg0: &mut AirdropPool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Eligibility {
        assert_sender_is_manager<T0, T1>(arg0, arg2);
        let v0 = 0x2::object::new(arg2);
        let v1 = NewEligibility<T0, T1>{
            id      : 0x2::object::uid_to_inner(&v0),
            pool_id : 0x2::object::id<AirdropPool<T0, T1>>(arg0),
            amount  : arg1,
        };
        0x2::event::emit<NewEligibility<T0, T1>>(v1);
        arg0.total_allocated = total_allocated<T0, T1>(arg0) + arg1;
        if (total_allocated<T0, T1>(arg0) > total_supply<T0, T1>(arg0)) {
            err_allocate_too_much();
        };
        Eligibility{
            id      : v0,
            amount  : arg1,
            pool_id : 0x2::object::id<AirdropPool<T0, T1>>(arg0),
        }
    }

    public fun amount(arg0: &Eligibility) : u64 {
        arg0.amount
    }

    fun assert_sender_is_manager<T0, T1>(arg0: &AirdropPool<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        if (!is_manager<T0, T1>(arg0, 0x2::tx_context::sender(arg1))) {
            err_sender_is_not_manager();
        };
    }

    public fun claim<T0, T1>(arg0: &mut AirdropPool<T0, T1>, arg1: &0x2::clock::Clock, arg2: Eligibility, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let (v1, v2) = time_settings<T0, T1>(arg0);
        if (v0 < v1) {
            err_airdrop_not_started();
        };
        if (v0 > v2) {
            err_airdrop_ended();
        };
        let Eligibility {
            id      : v3,
            amount  : v4,
            pool_id : v5,
        } = arg2;
        let v6 = v3;
        if (v5 != 0x2::object::id<AirdropPool<T0, T1>>(arg0)) {
            err_wrong_pool();
        };
        let v7 = Claim<T0, T1>{
            id      : 0x2::object::uid_to_inner(&v6),
            pool_id : v5,
            amount  : v4,
        };
        0x2::event::emit<Claim<T0, T1>>(v7);
        0x2::object::delete(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v4), arg3)
    }

    public fun create<T0, T1>(arg0: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<AirdropPool<T0, T1>>(new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public fun destroy<T0, T1>(arg0: AirdropPool<T0, T1>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::clock::timestamp_ms(arg2) <= arg0.end_time) {
            err_airdrop_not_ended();
        };
        let AirdropPool {
            id              : v0,
            total_supply    : _,
            total_allocated : _,
            balance         : v3,
            start_time      : _,
            end_time        : _,
            managers        : _,
        } = arg0;
        let v7 = v3;
        let v8 = v0;
        let v9 = DestroyAirdropPool<T0, T1>{
            pool_id : 0x2::object::uid_to_inner(&v8),
            surplus : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<DestroyAirdropPool<T0, T1>>(v9);
        0x2::object::delete(v8);
        0x2::coin::from_balance<T0>(v7, arg3)
    }

    fun err_airdrop_ended() {
        abort 2
    }

    fun err_airdrop_not_ended() {
        abort 1
    }

    fun err_airdrop_not_started() {
        abort 1
    }

    fun err_allocate_too_much() {
        abort 5
    }

    fun err_invalid_time_settings() {
        abort 0
    }

    fun err_sender_is_not_manager() {
        abort 4
    }

    fun err_wrong_pool() {
        abort 3
    }

    public fun is_manager<T0, T1>(arg0: &AirdropPool<T0, T1>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.managers, &arg1)
    }

    public fun pool_id(arg0: &Eligibility) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun remove_manager<T0, T1>(arg0: &mut AirdropPool<T0, T1>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T1>, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun supply<T0, T1>(arg0: &mut AirdropPool<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        arg0.total_supply = total_supply<T0, T1>(arg0) + 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun time_settings<T0, T1>(arg0: &AirdropPool<T0, T1>) : (u64, u64) {
        (arg0.start_time, arg0.end_time)
    }

    public fun total_allocated<T0, T1>(arg0: &AirdropPool<T0, T1>) : u64 {
        arg0.total_allocated
    }

    public fun total_supply<T0, T1>(arg0: &AirdropPool<T0, T1>) : u64 {
        arg0.total_supply
    }

    public fun update_stage<T0, T1>(arg0: &mut AirdropPool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0, T1>(arg0, arg3);
        arg0.start_time = arg1;
        arg0.end_time = arg2;
    }

    // decompiled from Move bytecode v6
}

