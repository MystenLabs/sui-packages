module 0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::voucher {
    struct Voucher<phantom T0> has key {
        id: 0x2::object::UID,
        amount: u64,
        deadline: u64,
    }

    struct SponsorPool<phantom T0> has key {
        id: 0x2::object::UID,
        asset: 0x2::balance::Balance<T0>,
        allocated: u64,
        remaining: u64,
    }

    struct SponsorPoolHost has key {
        id: 0x2::object::UID,
        pool_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct VoucherConsumeRequest<phantom T0> {
        request_amount: u64,
        base_provider: 0x2::object::ID,
    }

    struct PoolCap has key {
        id: 0x2::object::UID,
    }

    fun assert_if_over_sponsor_balance<T0>(arg0: &SponsorPool<T0>, arg1: u64) {
        assert!(arg0.remaining >= arg1, 1);
    }

    public fun base_provider<T0>(arg0: &VoucherConsumeRequest<T0>) : 0x2::object::ID {
        arg0.base_provider
    }

    fun burn_and_get_voucher_amount<T0>(arg0: &mut SponsorPool<T0>, arg1: Voucher<T0>, arg2: &0x2::clock::Clock) : u64 {
        let Voucher {
            id       : v0,
            amount   : v1,
            deadline : v2,
        } = arg1;
        0x2::object::delete(v0);
        if (v2 >= 0x2::clock::timestamp_ms(arg2)) {
            v1
        } else {
            increase_remaining<T0>(arg0, v1);
            0
        }
    }

    public(friend) fun burn_request<T0>(arg0: VoucherConsumeRequest<T0>) {
        let VoucherConsumeRequest {
            request_amount : _,
            base_provider  : _,
        } = arg0;
    }

    public fun consume<T0>(arg0: &0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::GlobalConfig, arg1: &mut SponsorPool<T0>, arg2: vector<Voucher<T0>>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, VoucherConsumeRequest<T0>) {
        0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::assert_if_version_not_matched(arg0, 1);
        let v0 = 0;
        while (0x1::vector::length<Voucher<T0>>(&arg2) != 0) {
            let v1 = burn_and_get_voucher_amount<T0>(arg1, 0x1::vector::pop_back<Voucher<T0>>(&mut arg2), arg3);
            v0 = v0 + v1;
        };
        0x1::vector::destroy_empty<Voucher<T0>>(arg2);
        let v2 = VoucherConsumeRequest<T0>{
            request_amount : v0,
            base_provider  : *0x2::object::uid_as_inner(&arg1.id),
        };
        (0x2::balance::split<T0>(&mut arg1.asset, v0), v2)
    }

    public fun deposit<T0>(arg0: &0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::GlobalConfig, arg1: &0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::AdminCap, arg2: &mut SponsorPool<T0>, arg3: 0x2::coin::Coin<T0>) {
        0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::assert_if_version_not_matched(arg0, 1);
        0x2::balance::join<T0>(&mut arg2.asset, 0x2::coin::into_balance<T0>(arg3));
        arg2.remaining = arg2.remaining + 0x2::coin::value<T0>(&arg3);
    }

    fun increase_remaining<T0>(arg0: &mut SponsorPool<T0>, arg1: u64) {
        arg0.remaining = arg0.remaining + arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SponsorPoolHost{
            id         : 0x2::object::new(arg0),
            pool_table : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<SponsorPoolHost>(v0);
    }

    fun mint<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Voucher<T0> {
        Voucher<T0>{
            id       : 0x2::object::new(arg2),
            amount   : arg0,
            deadline : arg1,
        }
    }

    public fun mint_to<T0>(arg0: &0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::GlobalConfig, arg1: &0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::AdminCap, arg2: &mut SponsorPool<T0>, arg3: vector<address>, arg4: vector<u64>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::assert_if_version_not_matched(arg0, 1);
        while (0x1::vector::length<address>(&arg3) > 0) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg4);
            assert_if_over_sponsor_balance<T0>(arg2, v0);
            arg2.allocated = arg2.allocated + v0;
            arg2.remaining = arg2.remaining - v0;
            0x2::transfer::transfer<Voucher<T0>>(mint<T0>(v0, 0x1::vector::pop_back<u64>(&mut arg5), arg6), 0x1::vector::pop_back<address>(&mut arg3));
        };
    }

    public fun new_sponsor_pool<T0>(arg0: &0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::GlobalConfig, arg1: &mut SponsorPoolHost, arg2: &0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::config::assert_if_version_not_matched(arg0, 1);
        let v0 = SponsorPool<T0>{
            id        : 0x2::object::new(arg3),
            asset     : 0x2::balance::zero<T0>(),
            allocated : 0,
            remaining : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.pool_table, 0x1::type_name::get<T0>(), *0x2::object::uid_as_inner(&v0.id));
        0x2::transfer::share_object<SponsorPool<T0>>(v0);
    }

    public(friend) fun put_back<T0>(arg0: &mut SponsorPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.asset, arg1);
    }

    public fun request_amount<T0>(arg0: &VoucherConsumeRequest<T0>) : u64 {
        arg0.request_amount
    }

    public(friend) fun sponsor_pool<T0>(arg0: &SponsorPoolHost) : 0x2::object::ID {
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pool_table, 0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

