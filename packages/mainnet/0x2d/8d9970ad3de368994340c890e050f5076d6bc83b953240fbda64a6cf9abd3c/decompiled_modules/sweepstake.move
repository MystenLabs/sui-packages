module 0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::sweepstake {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        coin_name: 0x1::string::String,
        user_balances: 0x2::table::Table<address, u64>,
        admin: 0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::admin::Admin,
        pubkey: vector<u8>,
    }

    struct NewTreasuryEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        owner: address,
        coin: 0x1::string::String,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        withdraw_id: 0x1::string::String,
        owner: address,
        coin: 0x1::string::String,
        amount: u64,
    }

    struct WithDrawer has copy, drop {
        withdraw_id: 0x1::string::String,
        from: address,
        amount: u64,
        to: address,
        deadline: u64,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        market_id: 0x1::string::String,
        creator: address,
        name: 0x1::string::String,
        conditions: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        yes_users: 0x2::vec_map::VecMap<address, u64>,
        no_users: 0x2::vec_map::VecMap<address, u64>,
        isClaimed: bool,
        winner: bool,
    }

    struct NewMarketEvent has copy, drop {
        object_id: 0x2::object::ID,
        market_id: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        order_id_yes: 0x1::string::String,
        user_yes: address,
        amount_yes: u64,
        order_id_no: 0x1::string::String,
        user_no: address,
        amount_no: u64,
    }

    struct TransferEvent has copy, drop {
        maker_order_id: 0x1::string::String,
        maker: address,
        taker_order_id: 0x1::string::String,
        taker: address,
        amount: u64,
        coin_type: bool,
    }

    struct MergeEvent has copy, drop {
        order_id_yes: 0x1::string::String,
        user_yes: address,
        amount_yes: u64,
        order_id_no: 0x1::string::String,
        user_no: address,
        amount_no: u64,
    }

    struct ClaimEvent has copy, drop {
        market_id: 0x1::string::String,
        winners: 0x2::vec_map::VecMap<address, u64>,
    }

    fun transfer(arg0: &mut Market, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: address, arg5: u64, arg6: bool) {
        if (arg6) {
            let v0 = check_yes_balance(arg0, arg2);
            assert!(v0 >= arg5, 1005);
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.yes_users, &arg2);
            0x2::vec_map::insert<address, u64>(&mut arg0.yes_users, arg2, v0 - arg5);
            if (!0x2::vec_map::contains<address, u64>(&arg0.yes_users, &arg4)) {
                0x2::vec_map::insert<address, u64>(&mut arg0.yes_users, arg4, arg5);
            } else {
                let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.yes_users, &arg4);
                0x2::vec_map::insert<address, u64>(&mut arg0.yes_users, arg4, *0x2::vec_map::get<address, u64>(&arg0.yes_users, &arg4) + arg5);
            };
        } else {
            let v5 = check_no_balance(arg0, arg2);
            assert!(v5 >= arg5, 1005);
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.no_users, &arg2);
            0x2::vec_map::insert<address, u64>(&mut arg0.no_users, arg2, v5 - arg5);
            if (!0x2::vec_map::contains<address, u64>(&arg0.no_users, &arg4)) {
                0x2::vec_map::insert<address, u64>(&mut arg0.no_users, arg4, arg5);
            } else {
                let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.no_users, &arg4);
                0x2::vec_map::insert<address, u64>(&mut arg0.no_users, arg4, *0x2::vec_map::get<address, u64>(&arg0.no_users, &arg4) + arg5);
            };
        };
        let v10 = TransferEvent{
            maker_order_id : arg1,
            maker          : arg2,
            taker_order_id : arg3,
            taker          : arg4,
            amount         : arg5,
            coin_type      : arg6,
        };
        0x2::event::emit<TransferEvent>(v10);
    }

    fun burn(arg0: &mut Market, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: address, arg6: u64) {
        let v0 = check_yes_balance(arg0, arg2);
        let v1 = check_no_balance(arg0, arg5);
        assert!(v0 >= arg3 && v1 >= arg6, 1005);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.yes_users, &arg2);
        0x2::vec_map::insert<address, u64>(&mut arg0.yes_users, arg2, v0 - arg3);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.no_users, &arg5);
        0x2::vec_map::insert<address, u64>(&mut arg0.no_users, arg5, v1 - arg6);
        let v6 = MergeEvent{
            order_id_yes : arg1,
            user_yes     : arg2,
            amount_yes   : arg3,
            order_id_no  : arg4,
            user_no      : arg5,
            amount_no    : arg6,
        };
        0x2::event::emit<MergeEvent>(v6);
    }

    public fun check_no_balance(arg0: &Market, arg1: address) : u64 {
        let v0 = arg0.no_users;
        let v1 = if (0x2::vec_map::contains<address, u64>(&v0, &arg1)) {
            0x2::vec_map::get<address, u64>(&v0, &arg1)
        } else {
            let v2 = 0;
            &v2
        };
        *v1
    }

    public fun check_yes_balance(arg0: &Market, arg1: address) : u64 {
        let v0 = arg0.yes_users;
        let v1 = if (0x2::vec_map::contains<address, u64>(&v0, &arg1)) {
            0x2::vec_map::get<address, u64>(&v0, &arg1)
        } else {
            let v2 = 0;
            &v2
        };
        *v1
    }

    entry fun claim_reward<T0>(arg0: &AdminCap, arg1: &mut Market, arg2: 0x1::string::String, arg3: bool, arg4: &mut Treasury<T0>) {
        assert!(arg1.market_id == arg2, 1008);
        assert!(arg1.isClaimed == false, 1007);
        arg1.isClaimed = true;
        if (arg3) {
            arg1.winner = true;
            let v0 = 0x2::vec_map::keys<address, u64>(&arg1.yes_users);
            let v1 = &v0;
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(v1)) {
                let v3 = *0x1::vector::borrow<address>(v1, v2);
                if (!0x2::table::contains<address, u64>(&arg4.user_balances, v3)) {
                    0x2::table::add<address, u64>(&mut arg4.user_balances, v3, 0);
                };
                0x2::table::add<address, u64>(&mut arg4.user_balances, v3, 0x2::table::remove<address, u64>(&mut arg4.user_balances, v3) + *0x2::vec_map::get<address, u64>(&arg1.yes_users, &v3) * 1000000);
                v2 = v2 + 1;
            };
        } else {
            arg1.winner = false;
            let v4 = 0x2::vec_map::keys<address, u64>(&arg1.no_users);
            let v5 = &v4;
            let v6 = 0;
            while (v6 < 0x1::vector::length<address>(v5)) {
                let v7 = *0x1::vector::borrow<address>(v5, v6);
                if (!0x2::table::contains<address, u64>(&arg4.user_balances, v7)) {
                    0x2::table::add<address, u64>(&mut arg4.user_balances, v7, 0);
                };
                0x2::table::add<address, u64>(&mut arg4.user_balances, v7, 0x2::table::remove<address, u64>(&mut arg4.user_balances, v7) + *0x2::vec_map::get<address, u64>(&arg1.no_users, &v7) * 1000000);
                v6 = v6 + 1;
            };
        };
    }

    entry fun create_market<T0>(arg0: &AdminCap, arg1: vector<0x1::string::String>, arg2: address, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &mut Treasury<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg7.user_balances, arg2);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v1 == 0x1::vector::length<0x1::string::String>(&arg3), 1010);
        assert!(arg6 > arg5, 1006);
        assert!(*v0 > v1 * 1000000, 1005);
        *v0 = *v0 - v1 * 1000000;
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg7.user_balances, @0x0);
        *v2 = *v2 + v1 * 1000000;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x2::object::new(arg8);
            let v5 = NewMarketEvent{
                object_id : 0x2::object::uid_to_inner(&v4),
                market_id : *0x1::vector::borrow<0x1::string::String>(&arg1, v3),
            };
            0x2::event::emit<NewMarketEvent>(v5);
            let v6 = Market{
                id         : v4,
                market_id  : *0x1::vector::borrow<0x1::string::String>(&arg1, v3),
                creator    : arg2,
                name       : *0x1::vector::borrow<0x1::string::String>(&arg3, v3),
                conditions : arg4,
                start_time : arg5,
                end_time   : arg6,
                yes_users  : 0x2::vec_map::empty<address, u64>(),
                no_users   : 0x2::vec_map::empty<address, u64>(),
                isClaimed  : false,
                winner     : false,
            };
            0x2::transfer::transfer<Market>(v6, 0x2::tx_context::sender(arg8));
            v3 = v3 + 1;
        };
    }

    entry fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        if (!0x2::table::contains<address, u64>(&arg0.user_balances, 0x2::tx_context::sender(arg2))) {
            0x2::table::add<address, u64>(&mut arg0.user_balances, 0x2::tx_context::sender(arg2), 0);
        };
        0x2::table::add<address, u64>(&mut arg0.user_balances, 0x2::tx_context::sender(arg2), 0x2::table::remove<address, u64>(&mut arg0.user_balances, 0x2::tx_context::sender(arg2)) + v0);
        let v1 = DepositEvent{
            owner  : 0x2::tx_context::sender(arg2),
            coin   : arg0.coin_name,
            amount : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    entry fun execute_order<T0>(arg0: &AdminCap, arg1: &mut Market, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: 0x1::string::String, arg6: address, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &mut Treasury<T0>) {
        assert!(arg1.isClaimed == false, 1007);
        if (arg9 == 0) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg11.user_balances, arg3);
            *v0 = *v0 - arg4 * arg10;
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg11.user_balances, arg6);
            *v1 = *v1 - arg7 * arg10;
            mint(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        } else if (arg9 == 1) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg11.user_balances, arg3);
            assert!(*v2 >= arg4 * arg10, 1005);
            *v2 = *v2 + arg4 * arg10;
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg11.user_balances, arg6);
            assert!(*v3 >= arg7 * arg10, 1005);
            *v3 = *v3 - arg7 * arg10;
            transfer(arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        } else if (arg9 == 2) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg11.user_balances, arg3);
            *v4 = *v4 + arg4 * arg10;
            let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg11.user_balances, arg6);
            *v5 = *v5 + arg7 * arg10;
            burn(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        };
    }

    public fun get_admin_pubkey<T0>(arg0: &Treasury<T0>) : vector<u8> {
        arg0.pubkey
    }

    public fun get_balance<T0>(arg0: &Treasury<T0>, arg1: address) : u64 {
        let v0 = &arg0.user_balances;
        let v1 = if (0x2::table::contains<address, u64>(v0, arg1)) {
            0x2::table::borrow<address, u64>(v0, arg1)
        } else {
            let v2 = 0;
            &v2
        };
        *v1
    }

    public fun get_conditions(arg0: &Market) : 0x1::string::String {
        arg0.conditions
    }

    public fun get_market_info(arg0: &Market) : (0x1::string::String, 0x1::string::String, u64, u64) {
        (arg0.name, arg0.conditions, arg0.start_time, arg0.end_time)
    }

    public fun get_no_users(arg0: &Market) : 0x2::vec_map::VecMap<address, u64> {
        arg0.no_users
    }

    public fun get_yes_users(arg0: &Market) : 0x2::vec_map::VecMap<address, u64> {
        arg0.yes_users
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun is_treasury_admin<T0>(arg0: &Treasury<T0>, arg1: address) : bool {
        0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::admin::is_admin(&arg0.admin, arg1)
    }

    fun mint(arg0: &mut Market, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: address, arg6: u64) {
        if (!0x2::vec_map::contains<address, u64>(&arg0.yes_users, &arg2)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.yes_users, arg2, arg3);
        } else {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.yes_users, &arg2);
            0x2::vec_map::insert<address, u64>(&mut arg0.yes_users, arg2, *0x2::vec_map::get<address, u64>(&arg0.yes_users, &arg2) + arg3);
        };
        if (!0x2::vec_map::contains<address, u64>(&arg0.no_users, &arg5)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.no_users, arg5, arg6);
        } else {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.no_users, &arg5);
            0x2::vec_map::insert<address, u64>(&mut arg0.no_users, arg5, *0x2::vec_map::get<address, u64>(&arg0.no_users, &arg5) + arg6);
        };
        let v4 = MintEvent{
            order_id_yes : arg1,
            user_yes     : arg2,
            amount_yes   : arg3,
            order_id_no  : arg4,
            user_no      : arg5,
            amount_no    : arg6,
        };
        0x2::event::emit<MintEvent>(v4);
    }

    entry fun new_treasury<T0>(arg0: &AdminCap, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = NewTreasuryEvent{id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<NewTreasuryEvent>(v1);
        let v2 = 0x2::table::new<address, u64>(arg3);
        0x2::table::add<address, u64>(&mut v2, @0x0, 0);
        let v3 = Treasury<T0>{
            id            : v0,
            balance       : 0x2::balance::zero<T0>(),
            coin_name     : arg1,
            user_balances : v2,
            admin         : 0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::admin::create_admin(arg3),
            pubkey        : arg2,
        };
        0x2::transfer::share_object<Treasury<T0>>(v3);
    }

    public(friend) fun num_treasury_admins<T0>(arg0: &Treasury<T0>) : u64 {
        0x2d8d9970ad3de368994340c890e050f5076d6bc83b953240fbda64a6cf9abd3c::admin::num_of_admin(&arg0.admin)
    }

    public(friend) fun set_treasury_pubkey<T0>(arg0: &mut Treasury<T0>, arg1: vector<u8>) {
        arg0.pubkey = arg1;
    }

    entry fun update_admin_pubkey<T0>(arg0: &mut Treasury<T0>, arg1: vector<u8>, arg2: &AdminCap) {
        arg0.pubkey = arg1;
    }

    entry fun withdraw<T0>(arg0: &mut Treasury<T0>, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, 0x2::tx_context::sender(arg6));
        assert!(*v0 >= arg2, 1002);
        let v1 = WithDrawer{
            withdraw_id : arg1,
            from        : 0x2::tx_context::sender(arg6),
            amount      : arg2,
            to          : arg3,
            deadline    : arg4,
        };
        let v2 = 0x2::bcs::to_bytes<WithDrawer>(&v1);
        let v3 = 0x2::hash::keccak256(&v2);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.pubkey, &v3), 1004);
        *v0 = *v0 - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg6), arg3);
        let v4 = WithdrawEvent{
            withdraw_id : arg1,
            owner       : arg3,
            coin        : arg0.coin_name,
            amount      : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v4);
    }

    public(friend) fun withdraw_from_treasury<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, @0x0);
        assert!(*v0 >= arg2, 1002);
        *v0 = *v0 - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

