module 0x7fb445e4857c137bc0589b5741622c8b4aa9630c32d560a1b321015e67536950::conditional_market {
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

    struct AdminCap has key {
        id: 0x2::object::UID,
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
            assert!(v0 >= arg5, 1001);
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
            assert!(v5 >= arg5, 1001);
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
        assert!(v0 >= arg3 && v1 >= arg6, 1001);
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

    entry fun claim_reward(arg0: &AdminCap, arg1: &mut Market, arg2: 0x1::string::String, arg3: bool) {
        assert!(arg1.market_id == arg2, 1004);
        assert!(arg1.isClaimed == false, 1003);
        arg1.isClaimed = true;
        if (arg3) {
            arg1.winner = true;
            let v0 = ClaimEvent{
                market_id : arg2,
                winners   : arg1.yes_users,
            };
            0x2::event::emit<ClaimEvent>(v0);
        } else {
            arg1.winner = false;
            let v1 = ClaimEvent{
                market_id : arg2,
                winners   : arg1.no_users,
            };
            0x2::event::emit<ClaimEvent>(v1);
        };
    }

    entry fun create_market(arg0: &AdminCap, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg6 > arg5, 1002);
        let v0 = 0x2::object::new(arg7);
        let v1 = NewMarketEvent{
            object_id : 0x2::object::uid_to_inner(&v0),
            market_id : arg1,
        };
        0x2::event::emit<NewMarketEvent>(v1);
        let v2 = Market{
            id         : v0,
            market_id  : arg1,
            creator    : arg2,
            name       : arg3,
            conditions : arg4,
            start_time : arg5,
            end_time   : arg6,
            yes_users  : 0x2::vec_map::empty<address, u64>(),
            no_users   : 0x2::vec_map::empty<address, u64>(),
            isClaimed  : false,
            winner     : false,
        };
        0x2::transfer::transfer<Market>(v2, 0x2::tx_context::sender(arg7));
        0x2::object::uid_to_address(&v0)
    }

    entry fun execute_order(arg0: &AdminCap, arg1: &mut Market, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: 0x1::string::String, arg6: address, arg7: u64, arg8: bool, arg9: u64) {
        if (arg9 == 0) {
            mint(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        } else if (arg9 == 1) {
            transfer(arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        } else if (arg9 == 2) {
            burn(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        };
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

    // decompiled from Move bytecode v6
}

