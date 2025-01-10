module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio {
    struct CetusPortfolio has key {
        id: 0x2::object::UID,
        positions: 0x2::linked_table::LinkedTable<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>,
    }

    struct CetusPositionInfo has copy, drop, store {
        id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity: u128,
    }

    struct FetchCetusPositionsEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        positions: vector<CetusPositionInfo>,
    }

    struct FetchCetusOwnersEvent has copy, drop, store {
        owners: vector<address>,
        total: u64,
    }

    struct FetchCetusAccountsEvent has copy, drop, store {
        owner: address,
        accounts: vector<0x1::ascii::String>,
        total: u64,
    }

    struct FetchAllCetusPositionsEvent has copy, drop, store {
        limit: 0x1::option::Option<u64>,
        offset: 0x1::option::Option<u64>,
        positions: vector<CetusPositionInfo>,
        done: bool,
    }

    fun add_account_if_not_exist(arg0: &mut 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0, arg1)) {
            0x2::linked_table::push_back<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0, arg1, 0x2::linked_table::new<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg2));
        };
    }

    fun add_owner_if_not_exist(arg0: &mut CetusPortfolio, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, arg1)) {
            0x2::linked_table::push_back<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&mut arg0.positions, arg1, 0x2::linked_table::new<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg2));
        };
    }

    fun borrow_or_new_positions_mut(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) : &mut 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        add_owner_if_not_exist(arg0, arg1, arg3);
        let v0 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&mut arg0.positions, arg1);
        add_account_if_not_exist(v0, arg2, arg3);
        0x2::linked_table::borrow_mut<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v0, arg2)
    }

    public(friend) fun borrow_position(arg0: &CetusPortfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x2::object::ID) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x2::linked_table::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(borrow_positions(arg0, arg1, arg2), arg3)
    }

    public(friend) fun borrow_position_mut(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x2::object::ID) : &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x2::linked_table::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(borrow_positions_mut(arg0, arg1, arg2), arg3)
    }

    fun borrow_positions(arg0: &CetusPortfolio, arg1: address, arg2: 0x1::ascii::String) : &0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        0x2::linked_table::borrow<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, arg1), arg2)
    }

    fun borrow_positions_mut(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::ascii::String) : &mut 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        0x2::linked_table::borrow_mut<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&mut arg0.positions, arg1), arg2)
    }

    public(friend) fun claim_all(arg0: &mut CetusPortfolio, arg1: address) {
        let v0 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&mut arg0.positions, arg1);
        let v1 = 0x2::linked_table::front<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v0);
        while (0x1::option::is_some<0x1::ascii::String>(v1)) {
            let v2 = *0x1::option::borrow<0x1::ascii::String>(v1);
            let v3 = 0x2::linked_table::borrow_mut<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v0, v2);
            let v4 = 0x2::linked_table::front<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v3);
            while (0x1::option::is_some<0x2::object::ID>(v4)) {
                let v5 = *0x1::option::borrow<0x2::object::ID>(v4);
                0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::linked_table::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v3, v5), arg1);
                v4 = 0x2::linked_table::next<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v3, v5);
            };
            v1 = 0x2::linked_table::next<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v0, v2);
        };
    }

    public fun cleanup(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::ascii::String) {
        if (has_account_positions(arg0, arg1, arg2)) {
            let v0 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&mut arg0.positions, arg1);
            if (0x2::linked_table::is_empty<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::linked_table::borrow<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v0, arg2))) {
                0x2::linked_table::destroy_empty<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::linked_table::remove<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v0, arg2));
            };
        };
    }

    public fun cleanup_all(arg0: &mut CetusPortfolio) {
        let v0 = 0x2::linked_table::front<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions);
        let v1 = 0x1::vector::empty<address>();
        while (0x1::option::is_some<address>(v0)) {
            let v2 = *0x1::option::borrow<address>(v0);
            let v3 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&mut arg0.positions, v2);
            let v4 = 0x2::linked_table::front<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v3);
            let v5 = 0x1::vector::empty<0x1::ascii::String>();
            while (0x1::option::is_some<0x1::ascii::String>(v4)) {
                let v6 = *0x1::option::borrow<0x1::ascii::String>(v4);
                if (0x2::linked_table::is_empty<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::linked_table::borrow_mut<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v3, v6))) {
                    0x1::vector::push_back<0x1::ascii::String>(&mut v5, v6);
                };
                v4 = 0x2::linked_table::next<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v3, v6);
            };
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x1::ascii::String>(&v5)) {
                0x2::linked_table::destroy_empty<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::linked_table::remove<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v3, *0x1::vector::borrow<0x1::ascii::String>(&v5, v7)));
                v7 = v7 + 1;
            };
            if (0x2::linked_table::is_empty<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v3)) {
                0x1::vector::push_back<address>(&mut v1, v2);
            };
            v0 = 0x2::linked_table::next<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, v2);
        };
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&v1)) {
            0x2::linked_table::destroy_empty<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(0x2::linked_table::remove<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&mut arg0.positions, *0x1::vector::borrow<address>(&v1, v8)));
            v8 = v8 + 1;
        };
    }

    public(friend) fun deposit_position(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::linked_table::push_back<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(borrow_or_new_positions_mut(arg0, arg1, arg2, arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3), arg3);
    }

    public fun fetch_accounts(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>) {
        let (v0, v1) = get_accounts(arg0, arg1, arg2, arg3);
        let v2 = FetchCetusAccountsEvent{
            owner    : arg1,
            accounts : v0,
            total    : v1,
        };
        0x2::event::emit<FetchCetusAccountsEvent>(v2);
    }

    public fun fetch_all_positions(arg0: &CetusPortfolio, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) {
        let (v0, v1) = get_all_positions(arg0, arg1, arg2);
        let v2 = FetchAllCetusPositionsEvent{
            limit     : arg1,
            offset    : arg2,
            positions : v0,
            done      : v1,
        };
        0x2::event::emit<FetchAllCetusPositionsEvent>(v2);
    }

    public fun fetch_owners(arg0: &mut CetusPortfolio, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) {
        let (v0, v1) = get_owners(arg0, arg1, arg2);
        let v2 = FetchCetusOwnersEvent{
            owners : v0,
            total  : v1,
        };
        0x2::event::emit<FetchCetusOwnersEvent>(v2);
    }

    public fun fetch_positions(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<0x2::object::ID>) {
        let v0 = FetchCetusPositionsEvent{
            owner        : arg1,
            account_name : arg2,
            positions    : get_positions(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<FetchCetusPositionsEvent>(v0);
    }

    public fun get_accounts(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>) : (vector<0x1::ascii::String>, u64) {
        if (0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, arg1)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::utils::linked_table_limit_keys<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&mut arg0.positions, arg1), arg2, arg3)
        } else {
            (0x1::vector::empty<0x1::ascii::String>(), 0)
        }
    }

    public fun get_all_positions(arg0: &CetusPortfolio, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) : (vector<CetusPositionInfo>, bool) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<CetusPositionInfo>();
        let v2 = 0x2::linked_table::front<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions);
        while (0x1::option::is_some<address>(v2)) {
            let v3 = *0x1::option::borrow<address>(v2);
            let v4 = 0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, v3);
            let v5 = 0x2::linked_table::front<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v4);
            while (0x1::option::is_some<0x1::ascii::String>(v5)) {
                let v6 = *0x1::option::borrow<0x1::ascii::String>(v5);
                let v7 = 0x2::linked_table::borrow<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v4, v6);
                let v8 = 0x2::linked_table::front<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v7);
                while (0x1::option::is_some<0x2::object::ID>(v8)) {
                    let v9 = *0x1::option::borrow<0x2::object::ID>(v8);
                    if (0x1::option::is_none<u64>(&arg2) || v0 >= *0x1::option::borrow<u64>(&arg2)) {
                        let v10 = 0x2::linked_table::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v7, v9);
                        let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v10);
                        let v13 = CetusPositionInfo{
                            id         : v9,
                            pool_id    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v10),
                            lower_tick : v11,
                            upper_tick : v12,
                            liquidity  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v10),
                        };
                        0x1::vector::push_back<CetusPositionInfo>(&mut v1, v13);
                        if (0x1::option::is_some<u64>(&arg1) && 0x1::vector::length<CetusPositionInfo>(&v1) >= *0x1::option::borrow<u64>(&arg1)) {
                            return (v1, false)
                        };
                    } else {
                        v0 = v0 + 1;
                    };
                    v8 = 0x2::linked_table::next<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v7, v9);
                };
                v5 = 0x2::linked_table::next<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v4, v6);
            };
            v2 = 0x2::linked_table::next<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, v3);
        };
        (v1, true)
    }

    public fun get_owners(arg0: &mut CetusPortfolio, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) : (vector<address>, u64) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::utils::linked_table_limit_keys<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, arg1, arg2)
    }

    public fun get_positions(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<0x2::object::ID>) : vector<CetusPositionInfo> {
        let v0 = 0x1::vector::empty<CetusPositionInfo>();
        if (has_account_positions(arg0, arg1, arg2)) {
            let v1 = 0x2::linked_table::borrow<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, arg1), arg2);
            let v2 = 0x2::linked_table::front<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v1);
            while (0x1::option::is_some<0x2::object::ID>(v2)) {
                let v3 = *0x1::option::borrow<0x2::object::ID>(v2);
                let v4 = 0x2::linked_table::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v1, v3);
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v4);
                if (0x1::option::is_none<0x2::object::ID>(&arg3) || 0x1::option::borrow<0x2::object::ID>(&arg3) == &v5) {
                    let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v4);
                    let v8 = CetusPositionInfo{
                        id         : v3,
                        pool_id    : v5,
                        lower_tick : v6,
                        upper_tick : v7,
                        liquidity  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4),
                    };
                    0x1::vector::push_back<CetusPositionInfo>(&mut v0, v8);
                };
                v2 = 0x2::linked_table::next<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v1, v3);
            };
        };
        v0
    }

    fun has_account_positions(arg0: &CetusPortfolio, arg1: address, arg2: 0x1::ascii::String) : bool {
        0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, arg1) && 0x2::linked_table::contains<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(&arg0.positions, arg1), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusPortfolio{
            id        : 0x2::object::new(arg0),
            positions : 0x2::linked_table::new<address, 0x2::linked_table::LinkedTable<0x1::ascii::String, 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>>(arg0),
        };
        0x2::transfer::share_object<CetusPortfolio>(v0);
    }

    public(friend) fun withdraw_position(arg0: &mut CetusPortfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x2::object::ID) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x2::linked_table::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(borrow_positions_mut(arg0, arg1, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

