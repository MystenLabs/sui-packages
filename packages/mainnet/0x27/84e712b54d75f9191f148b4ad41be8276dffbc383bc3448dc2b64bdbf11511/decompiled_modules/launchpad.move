module 0x2784e712b54d75f9191f148b4ad41be8276dffbc383bc3448dc2b64bdbf11511::launchpad {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        life_treasury: 0x2::balance::Balance<T0>,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        life_alloc: 0x2::table::Table<address, u64>,
        sui_paid: 0x2::table::Table<address, u64>,
        status: bool,
        claim_status: bool,
        rate_life_per_mist: u64,
        min_sui_mist: u64,
        sale_start_ms: u64,
        sale_end_ms: u64,
        per_user_cap: u64,
        max_life_for_sale: u64,
        total_deposit_life: u64,
        total_sold_life: u64,
        total_claimed_life: u64,
    }

    struct Bought has copy, drop {
        user: address,
        sui_amount: u64,
        life_amount: u64,
    }

    struct Claimed has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminDeposit has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminSuiWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminLifeWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminUpdateLaunchpad has copy, drop {
        user: address,
        status: bool,
    }

    struct AdminUpdateClaimStatus has copy, drop {
        user: address,
        claim_status: bool,
    }

    struct AdminUpdateRate has copy, drop {
        user: address,
        rate_life_per_mist: u64,
    }

    struct AdminUpdateWindow has copy, drop {
        user: address,
        start_ms: u64,
        end_ms: u64,
    }

    struct AdminUpdateCaps has copy, drop {
        user: address,
        per_user_cap: u64,
        max_life_for_sale: u64,
    }

    fun add_to_table(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, u64>(arg0, arg1)) {
            0x2::table::add<address, u64>(arg0, arg1, arg2);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
            *v0 = *v0 + arg2;
        };
    }

    entry fun admin_deposit<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut Treasury<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg2.life_treasury, arg1);
        arg2.total_deposit_life = arg2.total_deposit_life + v0;
        let v1 = AdminDeposit{
            user   : 0x2::tx_context::sender(arg3),
            amount : v0,
        };
        0x2::event::emit<AdminDeposit>(v1);
    }

    entry fun admin_withdraw_excess_life<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.status, 9);
        let v0 = outstanding_alloc<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&arg1.life_treasury);
        assert!(v1 >= v0, 8);
        let v2 = v1 - v0;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.life_treasury, v2, arg2), 0x2::tx_context::sender(arg2));
            let v3 = AdminLifeWithdrawn{
                user   : 0x2::tx_context::sender(arg2),
                amount : v2,
            };
            0x2::event::emit<AdminLifeWithdrawn>(v3);
        };
    }

    entry fun admin_withdraw_sui<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.status, 9);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_treasury, v0, arg2), 0x2::tx_context::sender(arg2));
        let v1 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v1);
    }

    entry fun buy<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.status, 1);
        check_window(arg2, arg1.sale_start_ms, arg1.sale_end_ms);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 >= arg1.min_sui_mist, 4);
        let v2 = v1 * arg1.rate_life_per_mist;
        assert!(v2 <= arg1.per_user_cap, 5);
        assert!(v2 <= arg1.per_user_cap - get_from_table_or_zero(&arg1.life_alloc, v0), 5);
        assert!(v2 <= arg1.max_life_for_sale, 6);
        assert!(v2 <= arg1.max_life_for_sale - arg1.total_sold_life, 6);
        assert!(0x2::balance::value<T0>(&arg1.life_treasury) >= outstanding_alloc<T0>(arg1) + v2, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v3 = &mut arg1.life_alloc;
        add_to_table(v3, v0, v2);
        let v4 = &mut arg1.sui_paid;
        add_to_table(v4, v0, v1);
        arg1.total_sold_life = arg1.total_sold_life + v2;
        let v5 = Bought{
            user        : v0,
            sui_amount  : v1,
            life_amount : v2,
        };
        0x2::event::emit<Bought>(v5);
    }

    entry fun buy_exact<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status, 1);
        check_window(arg2, arg1.sale_start_ms, arg1.sale_end_ms);
        assert!(arg3 >= arg1.rate_life_per_mist * arg1.min_sui_mist, 4);
        let v0 = ceil_div_u64(arg3, arg1.rate_life_per_mist);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 12);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg3 <= arg1.per_user_cap, 5);
        assert!(arg3 <= arg1.per_user_cap - get_from_table_or_zero(&arg1.life_alloc, v1), 5);
        assert!(arg3 <= arg1.max_life_for_sale, 6);
        assert!(arg3 <= arg1.max_life_for_sale - arg1.total_sold_life, 6);
        assert!(0x2::balance::value<T0>(&arg1.life_treasury) >= outstanding_alloc<T0>(arg1) + arg3, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg4)));
        let v2 = &mut arg1.life_alloc;
        add_to_table(v2, v1, arg3);
        let v3 = &mut arg1.sui_paid;
        add_to_table(v3, v1, v0);
        arg1.total_sold_life = arg1.total_sold_life + arg3;
        let v4 = Bought{
            user        : v1,
            sui_amount  : v0,
            life_amount : arg3,
        };
        0x2::event::emit<Bought>(v4);
    }

    fun ceil_div_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 11);
        (arg0 + arg1 - 1) / arg1
    }

    fun check_window(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64) {
        let v0 = now_ms(arg0);
        if (arg1 > 0) {
            assert!(v0 >= arg1, 2);
        };
        if (arg2 > 0) {
            assert!(v0 <= arg2, 3);
        };
    }

    entry fun claim<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claim_status, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.life_alloc, v0), 7);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.life_alloc, v0);
        let v2 = *v1;
        assert!(v2 > 0, 7);
        assert!(0x2::balance::value<T0>(&arg0.life_treasury) >= v2, 8);
        *v1 = 0;
        arg0.total_claimed_life = arg0.total_claimed_life + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.life_treasury, v2, arg1), v0);
        let v3 = Claimed{
            user   : v0,
            amount : v2,
        };
        0x2::event::emit<Claimed>(v3);
    }

    fun get_from_table_or_zero(arg0: &0x2::table::Table<address, u64>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(arg0, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(arg0, arg1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun new_launchpad<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 11);
        assert!(arg2 > 0, 4);
        if (arg6 > 0) {
            assert!(arg5 == 0 || arg6 >= arg5, 10);
        };
        let v0 = Treasury<T0>{
            id                 : 0x2::object::new(arg7),
            life_treasury      : 0x2::balance::zero<T0>(),
            sui_treasury       : 0x2::balance::zero<0x2::sui::SUI>(),
            life_alloc         : 0x2::table::new<address, u64>(arg7),
            sui_paid           : 0x2::table::new<address, u64>(arg7),
            status             : true,
            claim_status       : false,
            rate_life_per_mist : arg1,
            min_sui_mist       : arg2,
            sale_start_ms      : arg5,
            sale_end_ms        : arg6,
            per_user_cap       : arg3,
            max_life_for_sale  : arg4,
            total_deposit_life : 0,
            total_sold_life    : 0,
            total_claimed_life : 0,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    fun now_ms(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    fun outstanding_alloc<T0>(arg0: &Treasury<T0>) : u64 {
        assert!(arg0.total_sold_life >= arg0.total_claimed_life, 8);
        arg0.total_sold_life - arg0.total_claimed_life
    }

    entry fun update_caps<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        arg1.per_user_cap = arg2;
        arg1.max_life_for_sale = arg3;
        let v0 = AdminUpdateCaps{
            user              : 0x2::tx_context::sender(arg4),
            per_user_cap      : arg2,
            max_life_for_sale : arg3,
        };
        0x2::event::emit<AdminUpdateCaps>(v0);
    }

    entry fun update_claim_status<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        arg1.claim_status = arg2;
        let v0 = AdminUpdateClaimStatus{
            user         : 0x2::tx_context::sender(arg3),
            claim_status : arg2,
        };
        0x2::event::emit<AdminUpdateClaimStatus>(v0);
    }

    entry fun update_launchpad<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        arg1.status = arg2;
        let v0 = AdminUpdateLaunchpad{
            user   : 0x2::tx_context::sender(arg3),
            status : arg2,
        };
        0x2::event::emit<AdminUpdateLaunchpad>(v0);
    }

    entry fun update_rate<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 11);
        arg1.rate_life_per_mist = arg2;
        let v0 = AdminUpdateRate{
            user               : 0x2::tx_context::sender(arg3),
            rate_life_per_mist : arg2,
        };
        0x2::event::emit<AdminUpdateRate>(v0);
    }

    entry fun update_window<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            assert!(arg2 == 0 || arg3 >= arg2, 10);
        };
        arg1.sale_start_ms = arg2;
        arg1.sale_end_ms = arg3;
        let v0 = AdminUpdateWindow{
            user     : 0x2::tx_context::sender(arg4),
            start_ms : arg2,
            end_ms   : arg3,
        };
        0x2::event::emit<AdminUpdateWindow>(v0);
    }

    // decompiled from Move bytecode v6
}

