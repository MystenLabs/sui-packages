module 0x67c92a8e87918424a4fb90278af428e92e81176e4bc40926c0be7ea8917b99ef::daosui {
    struct DAOSUI has drop {
        dummy_field: bool,
    }

    struct DaoSui<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        init_coin_fee: u64,
        chat_fee: u64,
        daosui_balance: 0x2::balance::Balance<T0>,
        version: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_coin: 0x2::balance::Balance<T0>,
        total_sui_commit: u64,
        total_supply: u64,
        total_sui_raise: u64,
        is_started: bool,
        fund_raise_end: u64,
        fund_end: u64,
        complete: bool,
        creator: address,
    }

    struct Participant has store {
        sender: address,
        max_sui: u64,
        commit_sui: u64,
        is_withdraw: bool,
        is_claim: bool,
    }

    struct CreatePoolEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        decimals: u8,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        total_supply: u64,
        total_sui_raise: u64,
        creator_carry: u64,
        sender: address,
        token_address: 0x1::type_name::TypeName,
        x: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
    }

    struct StartPoolEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        fund_raise_end: u64,
        fund_end: u64,
    }

    struct AddParticipantEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        max_sui: u64,
        is_withdraw: bool,
        commit_sui: u64,
        is_claim: bool,
    }

    struct ParticipantCommitEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        commit_sui: u64,
        commit_amount: u64,
        pool_sui: u64,
    }

    struct CompletedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_address: 0x1::type_name::TypeName,
        coin_amount: u64,
        pool_sui: u64,
    }

    struct ParticipantWithdrawEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct ParticipantClaimEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct MessageEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        message: 0x1::string::String,
    }

    public entry fun add_participant<T0, T1>(arg0: &mut DaoSui<T0>, arg1: &mut Pool<T1>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        assert!(arg1.creator == 0x2::tx_context::sender(arg4), 3);
        let v0 = 0x1::vector::length<address>(&arg2);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0x1::vector::pop_back<u64>(&mut arg3);
            if (!0x2::dynamic_field::exists_<address>(&arg1.id, v1)) {
                let v3 = Participant{
                    sender      : v1,
                    max_sui     : v2,
                    commit_sui  : 0,
                    is_withdraw : false,
                    is_claim    : false,
                };
                0x2::dynamic_field::add<address, Participant>(&mut arg1.id, v1, v3);
                let v4 = AddParticipantEvent{
                    sender      : v1,
                    pool_id     : 0x2::object::id<Pool<T1>>(arg1),
                    max_sui     : v2,
                    is_withdraw : false,
                    commit_sui  : 0,
                    is_claim    : false,
                };
                0x2::event::emit<AddParticipantEvent>(v4);
            };
        };
    }

    public entry fun claim<T0, T1>(arg0: &mut DaoSui<T0>, arg1: &mut Pool<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_<address>(&arg1.id, v0), 4);
        let v1 = if (arg1.total_sui_commit > arg1.total_sui_raise) {
            if (arg1.complete == false) {
                0x2::clock::timestamp_ms(arg2) > arg1.fund_raise_end
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            arg1.complete = true;
            let v2 = 0x2::balance::value<T1>(&arg1.pool_coin);
            let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.pool_coin, v2 / 10, arg3), @0x2180142a4b4790feb8feb57ce095a331f481d7892ec0a26adc2aaa7c7a028b3e);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, v3, arg3), @0x2180142a4b4790feb8feb57ce095a331f481d7892ec0a26adc2aaa7c7a028b3e);
            let v4 = CompletedEvent{
                pool_id       : 0x2::object::id<Pool<T1>>(arg1),
                token_address : 0x1::type_name::get<T1>(),
                coin_amount   : v2 / 10,
                pool_sui      : v3,
            };
            0x2::event::emit<CompletedEvent>(v4);
        };
        assert!(arg1.complete, 8);
        let v5 = 0x2::dynamic_field::borrow_mut<address, Participant>(&mut arg1.id, v0);
        assert!(!v5.is_claim, 8);
        let v6 = (v5.commit_sui as u128) * 9 * (arg1.total_supply as u128) / 10 / (arg1.total_sui_commit as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.pool_coin, (v6 as u64), arg3), v0);
        v5.commit_sui = 0;
        v5.is_claim = true;
        let v7 = ParticipantClaimEvent{
            sender  : v5.sender,
            pool_id : 0x2::object::id<Pool<T1>>(arg1),
            amount  : (v6 as u64),
        };
        0x2::event::emit<ParticipantClaimEvent>(v7);
    }

    public entry fun commit<T0, T1>(arg0: &mut DaoSui<T0>, arg1: &mut Pool<T1>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::dynamic_field::exists_<address>(&arg1.id, v0), 4);
        assert!(arg1.is_started, 6);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.fund_raise_end, 7);
        let v1 = 0x2::dynamic_field::borrow_mut<address, Participant>(&mut arg1.id, v0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v3 = arg1.total_sui_raise * 11 / 10 - 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui);
        let v4 = if (v2 < v3) {
            v2
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2 - v3, arg4), v0);
            arg1.complete = true;
            v3
        };
        assert!(v1.commit_sui + v4 <= v1.max_sui, 5);
        v1.commit_sui = v1.commit_sui + v4;
        arg1.total_sui_commit = arg1.total_sui_commit + v4;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v5 = ParticipantCommitEvent{
            sender        : v1.sender,
            pool_id       : 0x2::object::id<Pool<T1>>(arg1),
            commit_sui    : v1.commit_sui,
            commit_amount : v4,
            pool_sui      : 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui),
        };
        0x2::event::emit<ParticipantCommitEvent>(v5);
        if (arg1.complete == true) {
            let v6 = 0x2::balance::value<T1>(&arg1.pool_coin);
            let v7 = 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.pool_coin, v6 / 10, arg4), @0x2180142a4b4790feb8feb57ce095a331f481d7892ec0a26adc2aaa7c7a028b3e);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, v7, arg4), @0x2180142a4b4790feb8feb57ce095a331f481d7892ec0a26adc2aaa7c7a028b3e);
            let v8 = CompletedEvent{
                pool_id       : 0x2::object::id<Pool<T1>>(arg1),
                token_address : 0x1::type_name::get<T1>(),
                coin_amount   : v6 / 10,
                pool_sui      : v7,
            };
            0x2::event::emit<CompletedEvent>(v8);
        };
    }

    public entry fun init_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x2180142a4b4790feb8feb57ce095a331f481d7892ec0a26adc2aaa7c7a028b3e, 3);
        let v0 = DaoSui<T0>{
            id             : 0x2::object::new(arg0),
            admin          : @0x2180142a4b4790feb8feb57ce095a331f481d7892ec0a26adc2aaa7c7a028b3e,
            init_coin_fee  : 100000000,
            chat_fee       : 6900000,
            daosui_balance : 0x2::balance::zero<T0>(),
            version        : 1,
        };
        0x2::transfer::share_object<DaoSui<T0>>(v0);
    }

    public entry fun send_message<T0, T1>(arg0: &mut DaoSui<T0>, arg1: &mut Pool<T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        assert!(0x2::coin::value<T0>(&arg2) == arg0.chat_fee, 1);
        let v0 = MessageEvent{
            pool_id : 0x2::object::id<Pool<T1>>(arg1),
            sender  : 0x2::tx_context::sender(arg4),
            message : arg3,
        };
        0x2::event::emit<MessageEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, @0x0);
    }

    public entry fun start_dao<T0, T1>(arg0: &mut DaoSui<T0>, arg1: &mut Pool<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.creator == 0x2::tx_context::sender(arg3), 3);
        assert!(!arg1.is_started, 11);
        arg1.is_started = true;
        arg1.fund_raise_end = v0 + 420000;
        arg1.fund_end = v0 + 420000 + 21900000;
        let v1 = StartPoolEvent{
            pool_id        : 0x2::object::id<Pool<T1>>(arg1),
            fund_raise_end : arg1.fund_raise_end,
            fund_end       : arg1.fund_end,
        };
        0x2::event::emit<StartPoolEvent>(v1);
    }

    public entry fun start_dao2<T0, T1>(arg0: &mut DaoSui<T0>, arg1: &mut Pool<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.creator == 0x2::tx_context::sender(arg3), 3);
        arg1.is_started = true;
        arg1.fund_raise_end = v0 + 420000;
        arg1.fund_end = v0 + 420000 + 21900000;
        let v1 = StartPoolEvent{
            pool_id        : 0x2::object::id<Pool<T1>>(arg1),
            fund_raise_end : arg1.fund_raise_end,
            fund_end       : arg1.fund_end,
        };
        0x2::event::emit<StartPoolEvent>(v1);
    }

    public entry fun start_new_dao<T0, T1>(arg0: &mut DaoSui<T0>, arg1: 0x2::coin::CoinMetadata<T1>, arg2: 0x2::coin::TreasuryCap<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::coin::total_supply<T1>(&arg2) == 0, 0);
        assert!(0x2::coin::value<T0>(&arg3) == arg0.init_coin_fee, 1);
        assert!(arg5 <= 20, 1);
        let v1 = Pool<T1>{
            id               : 0x2::object::new(arg9),
            pool_sui         : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_coin        : 0x2::coin::into_balance<T1>(0x2::coin::mint<T1>(&mut arg2, 1000000000000000, arg9)),
            total_sui_commit : 0,
            total_supply     : 1000000000000000,
            total_sui_raise  : arg4,
            is_started       : false,
            fund_raise_end   : 0,
            fund_end         : 0,
            complete         : false,
            creator          : v0,
        };
        let v2 = CreatePoolEvent{
            pool_id         : 0x2::object::id<Pool<T1>>(&v1),
            name            : 0x2::coin::get_name<T1>(&arg1),
            symbol          : 0x2::coin::get_symbol<T1>(&arg1),
            decimals        : 0x2::coin::get_decimals<T1>(&arg1),
            description     : 0x2::coin::get_description<T1>(&arg1),
            icon_url        : 0x2::coin::get_icon_url<T1>(&arg1),
            total_supply    : 1000000000000000,
            total_sui_raise : arg4,
            creator_carry   : arg5,
            sender          : v0,
            token_address   : 0x1::type_name::get<T1>(),
            x               : arg6,
            telegram        : arg7,
            website         : arg8,
        };
        0x2::event::emit<CreatePoolEvent>(v2);
        0x2::transfer::public_share_object<Pool<T1>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T1>>(arg2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T1>>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, @0x0);
    }

    public entry fun update_fee<T0>(arg0: &mut DaoSui<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 3);
        arg0.chat_fee = arg1;
        arg0.init_coin_fee = arg2;
    }

    public entry fun update_version<T0>(arg0: &mut DaoSui<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 3);
        arg0.version = 1;
    }

    public entry fun withdraw<T0, T1>(arg0: &mut DaoSui<T0>, arg1: &mut Pool<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_<address>(&arg1.id, v0), 4);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.fund_raise_end && !arg1.complete, 8);
        let v1 = 0x2::dynamic_field::borrow_mut<address, Participant>(&mut arg1.id, v0);
        assert!(!v1.is_withdraw, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, v1.commit_sui, arg3), v0);
        v1.commit_sui = 0;
        v1.is_withdraw = true;
        let v2 = ParticipantWithdrawEvent{
            sender  : v1.sender,
            pool_id : 0x2::object::id<Pool<T1>>(arg1),
            amount  : v1.commit_sui,
        };
        0x2::event::emit<ParticipantWithdrawEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

