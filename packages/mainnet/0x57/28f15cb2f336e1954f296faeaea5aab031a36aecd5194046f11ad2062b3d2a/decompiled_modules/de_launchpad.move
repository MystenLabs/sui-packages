module 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::de_launchpad {
    struct NewLaunchpad<phantom T0, phantom T1, phantom T2> has copy, drop {
        pad_id: 0x2::object::ID,
        total_sale: u64,
        max_public_quota: u64,
        price: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        stage_config: 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::StageConfig,
    }

    struct WithdrawLaunchpad<phantom T0, phantom T1, phantom T2> has copy, drop {
        pad_id: 0x2::object::ID,
        surplus: u64,
        earning: u64,
    }

    struct WhitelistPurchase<phantom T0, phantom T1, phantom T2> has copy, drop {
        pad_id: 0x2::object::ID,
        account: address,
        amount: u64,
    }

    struct PublicPurchase<phantom T0, phantom T1, phantom T2> has copy, drop {
        pad_id: 0x2::object::ID,
        account: address,
        amount: u64,
    }

    struct DeLaunchpad<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        pool_in: 0x2::balance::Balance<T0>,
        pool_out: 0x2::balance::Balance<T1>,
        whitelist_allocations: 0x2::table::Table<address, Allocation>,
        public_allocations: 0x2::table::Table<address, Allocation>,
        whitelist_total_sale: u64,
        public_total_sale: u64,
        max_public_quota: u64,
        price: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        stage_config: 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::StageConfig,
        managers: 0x2::vec_set::VecSet<address>,
    }

    struct Allocation has copy, drop, store {
        quota: u64,
        allocated: u64,
    }

    public fun destroy_empty<T0, T1, T2>(arg0: DeLaunchpad<T0, T1, T2>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T2>) {
        let DeLaunchpad {
            id                    : v0,
            pool_in               : v1,
            pool_out              : v2,
            whitelist_allocations : v3,
            public_allocations    : v4,
            whitelist_total_sale  : _,
            public_total_sale     : _,
            max_public_quota      : _,
            price                 : _,
            stage_config          : _,
            managers              : _,
        } = arg0;
        let v11 = v2;
        let v12 = v1;
        0x2::object::delete(v0);
        if (0x2::balance::value<T0>(&v12) > 0 || 0x2::balance::value<T1>(&v11) > 0) {
            err_cannot_destroy_non_empty();
        };
        0x2::balance::destroy_zero<T0>(v12);
        0x2::balance::destroy_zero<T1>(v11);
        0x2::table::drop<address, Allocation>(v3);
        0x2::table::drop<address, Allocation>(v4);
    }

    public fun new<T0, T1, T2>(arg0: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T2>, arg1: &0x2::clock::Clock, arg2: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float, arg3: u64, arg4: 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::StageConfig, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : DeLaunchpad<T0, T1, T2> {
        if (0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::whitelist_time(&arg4) < 0x2::clock::timestamp_ms(arg1)) {
            err_invalid_stage_config();
        };
        let v0 = 0x2::object::new(arg6);
        let v1 = NewLaunchpad<T0, T1, T2>{
            pad_id           : 0x2::object::uid_to_inner(&v0),
            total_sale       : 0x2::coin::value<T1>(&arg5),
            max_public_quota : arg3,
            price            : arg2,
            stage_config     : arg4,
        };
        0x2::event::emit<NewLaunchpad<T0, T1, T2>>(v1);
        DeLaunchpad<T0, T1, T2>{
            id                    : v0,
            pool_in               : 0x2::balance::zero<T0>(),
            pool_out              : 0x2::coin::into_balance<T1>(arg5),
            whitelist_allocations : 0x2::table::new<address, Allocation>(arg6),
            public_allocations    : 0x2::table::new<address, Allocation>(arg6),
            whitelist_total_sale  : 0,
            public_total_sale     : 0,
            max_public_quota      : arg3,
            price                 : arg2,
            stage_config          : arg4,
            managers              : 0x2::vec_set::empty<address>(),
        }
    }

    public fun add_manager<T0, T1, T2>(arg0: &mut DeLaunchpad<T0, T1, T2>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T2>, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun allocate<T0, T1, T2>(arg0: &mut DeLaunchpad<T0, T1, T2>, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0, T1, T2>(arg0, arg3);
        if (0x2::table::contains<address, Allocation>(&arg0.whitelist_allocations, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, Allocation>(&mut arg0.whitelist_allocations, arg1);
            v0.quota = quota(v0) + arg2;
        } else {
            let v1 = Allocation{
                quota     : arg2,
                allocated : 0,
            };
            0x2::table::add<address, Allocation>(&mut arg0.whitelist_allocations, arg1, v1);
        };
    }

    public fun allocated(arg0: &Allocation) : u64 {
        arg0.allocated
    }

    fun assert_sender_is_manager<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        if (!is_manager<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg1))) {
            err_sender_is_not_manager();
        };
    }

    public fun deallocate<T0, T1, T2>(arg0: &mut DeLaunchpad<T0, T1, T2>, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0, T1, T2>(arg0, arg3);
        if (0x2::table::contains<address, Allocation>(&arg0.whitelist_allocations, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, Allocation>(&mut arg0.whitelist_allocations, arg1);
            if (remaining_amount(v0) <= arg2) {
                0x2::table::remove<address, Allocation>(&mut arg0.whitelist_allocations, arg1);
            } else {
                v0.quota = quota(v0) - arg2;
            };
        };
    }

    public fun default<T0, T1, T2>(arg0: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T2>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DeLaunchpad<T0, T1, T2>>(new<T0, T1, T2>(arg0, arg1, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(arg7, 0x2::coin::value<T1>(&arg6)), arg2, 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::new_config(arg3, arg4, arg5), arg6, arg8));
    }

    fun err_cannot_destroy_non_empty() {
        abort 9
    }

    fun err_cannot_set_price_after_started() {
        abort 10
    }

    fun err_cannot_withdraw_pool_when_saling() {
        abort 7
    }

    fun err_invalid_stage_config() {
        abort 1
    }

    fun err_no_allocation() {
        abort 3
    }

    fun err_payment_not_enough() {
        abort 4
    }

    fun err_sales_ended() {
        abort 5
    }

    fun err_sales_not_started() {
        abort 2
    }

    fun err_sender_is_not_manager() {
        abort 8
    }

    fun err_sold_out() {
        abort 6
    }

    public fun is_manager<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.managers, &arg1)
    }

    public fun max_public_quota<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>) : u64 {
        arg0.max_public_quota
    }

    public fun pool_in<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>) : &0x2::balance::Balance<T0> {
        &arg0.pool_in
    }

    public fun pool_out<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>) : &0x2::balance::Balance<T1> {
        &arg0.pool_out
    }

    public fun public_allocation_of<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>, arg1: address) : &Allocation {
        0x2::table::borrow<address, Allocation>(&arg0.public_allocations, arg1)
    }

    public fun public_total_sale<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>) : u64 {
        arg0.public_total_sale
    }

    public fun purchase<T0, T1, T2>(arg0: &mut DeLaunchpad<T0, T1, T2>, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeCenter<T1, T2>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg6: &mut 0x2::tx_context::TxContext) : (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T1, T2>, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeTokenUpdateResponse<T1, T2>) {
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::destroy(arg5);
        let v1 = 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::get_stage(&arg0.stage_config, arg2);
        let v2 = 0x2::balance::value<T1>(pool_out<T0, T1, T2>(arg0));
        if (v2 == 0) {
            err_sold_out();
        };
        if (arg3 > v2) {
            arg3 = v2;
        };
        if (v1 == 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::not_started()) {
            err_sales_not_started();
        };
        if (v1 == 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::ended()) {
            err_sales_ended();
        };
        if (v1 == 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::whitelist_sale()) {
            if (!0x2::table::contains<address, Allocation>(&arg0.whitelist_allocations, v0)) {
                err_no_allocation();
            };
            let v3 = 0x2::table::borrow_mut<address, Allocation>(&mut arg0.whitelist_allocations, v0);
            if (remaining_amount(v3) > arg3) {
                v3.allocated = allocated(v3) + arg3;
            } else {
                arg3 = remaining_amount(v3);
                v3.allocated = quota(v3);
            };
            arg0.whitelist_total_sale = whitelist_total_sale<T0, T1, T2>(arg0) + arg3;
            let v4 = WhitelistPurchase<T0, T1, T2>{
                pad_id  : 0x2::object::id<DeLaunchpad<T0, T1, T2>>(arg0),
                account : v0,
                amount  : arg3,
            };
            0x2::event::emit<WhitelistPurchase<T0, T1, T2>>(v4);
        } else {
            let v5 = max_public_quota<T0, T1, T2>(arg0);
            if (0x2::table::contains<address, Allocation>(&arg0.public_allocations, v0)) {
                let v6 = 0x2::table::borrow_mut<address, Allocation>(&mut arg0.public_allocations, v0);
                if (arg3 >= remaining_amount(v6)) {
                    arg3 = remaining_amount(v6);
                    v6.allocated = v5;
                } else {
                    v6.allocated = allocated(v6) + arg3;
                };
            } else {
                if (arg3 >= v5) {
                    arg3 = v5;
                };
                let v7 = Allocation{
                    quota     : v5,
                    allocated : arg3,
                };
                0x2::table::add<address, Allocation>(&mut arg0.public_allocations, v0, v7);
            };
            arg0.public_total_sale = public_total_sale<T0, T1, T2>(arg0) + arg3;
            let v8 = PublicPurchase<T0, T1, T2>{
                pad_id  : 0x2::object::id<DeLaunchpad<T0, T1, T2>>(arg0),
                account : v0,
                amount  : arg3,
            };
            0x2::event::emit<PublicPurchase<T0, T1, T2>>(v8);
        };
        if (arg3 == 0) {
            err_no_allocation();
        };
        let v9 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(arg0.price, arg3));
        if (0x2::coin::value<T0>(arg4) < v9) {
            err_payment_not_enough();
        };
        0x2::balance::join<T0>(&mut arg0.pool_in, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg4), v9));
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::lock<T1, T2>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pool_out, arg3), arg6), 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::max_time<T1, T2>(arg1) - 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::week(), false, arg2, arg6)
    }

    public fun quota(arg0: &Allocation) : u64 {
        arg0.quota
    }

    public fun remaining_amount(arg0: &Allocation) : u64 {
        quota(arg0) - allocated(arg0)
    }

    public fun remove_manager<T0, T1, T2>(arg0: &mut DeLaunchpad<T0, T1, T2>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T2>, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun required_payment_amount<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>, arg1: u64) : u64 {
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(arg0.price, arg1))
    }

    public fun set_price<T0, T1, T2>(arg0: &mut DeLaunchpad<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0, T1, T2>(arg0, arg4);
        if (0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::get_stage(&arg0.stage_config, arg1) != 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::not_started()) {
            err_cannot_set_price_after_started();
        };
        arg0.price = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(arg2, arg3);
    }

    public fun update_time_settings<T0, T1, T2>(arg0: &mut DeLaunchpad<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_sender_is_manager<T0, T1, T2>(arg0, arg4);
        arg0.stage_config = 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::new_config(arg1, arg2, arg3);
    }

    public fun whitelist_allocation_of<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>, arg1: address) : &Allocation {
        0x2::table::borrow<address, Allocation>(&arg0.whitelist_allocations, arg1)
    }

    public fun whitelist_total_sale<T0, T1, T2>(arg0: &DeLaunchpad<T0, T1, T2>) : u64 {
        arg0.whitelist_total_sale
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut DeLaunchpad<T0, T1, T2>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::AdminCap<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::get_stage(&arg0.stage_config, arg2);
        if (v0 == 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::whitelist_sale() || v0 == 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::stage::public_sale()) {
            err_cannot_withdraw_pool_when_saling();
        };
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pool_in), arg3);
        let v2 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.pool_out), arg3);
        let v3 = WithdrawLaunchpad<T0, T1, T2>{
            pad_id  : 0x2::object::id<DeLaunchpad<T0, T1, T2>>(arg0),
            surplus : 0x2::coin::value<T1>(&v2),
            earning : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<WithdrawLaunchpad<T0, T1, T2>>(v3);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

