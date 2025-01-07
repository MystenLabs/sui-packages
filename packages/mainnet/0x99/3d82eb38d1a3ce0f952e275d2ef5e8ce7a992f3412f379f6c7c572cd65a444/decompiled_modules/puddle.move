module 0x993d82eb38d1a3ce0f952e275d2ef5e8ce7a992f3412f379f6c7c572cd65a444::puddle {
    struct Puddles<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        commission_percentage: u8,
        state: PuddleState,
        holder_info: HolderInfo,
        market_info: MarketInfo,
        investments: InvestmentsRecord,
        metadata: PuddleMetaData,
    }

    struct PuddleStatistics has key {
        id: 0x2::object::UID,
        in_progress_puddles: vector<0x2::object::ID>,
        closed_puddles: vector<0x2::object::ID>,
        puddle_owner_table: 0x2::table::Table<0x2::object::ID, address>,
    }

    struct PuddleState has store {
        is_close: bool,
        is_stop_mint: bool,
    }

    struct InvestmentsRecord has store {
        invests: vector<0x2::object::ID>,
        cost_table: 0x2::table::Table<0x2::object::ID, u64>,
        balance_bag: 0x2::bag::Bag,
        total_rewards: u64,
    }

    struct MarketInfo has store {
        items: vector<0x2::object::ID>,
        item_listing_table: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct HolderInfo has store {
        holders: vector<address>,
        holder_amount_table: 0x2::table::Table<address, u64>,
    }

    struct PuddleMetaData has store {
        max_supply: u64,
        total_supply: u64,
        trader: address,
        name: 0x1::string::String,
        desc: 0x1::string::String,
    }

    struct PuddleShares<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        shares: u64,
        puddle_id: 0x2::object::ID,
        owner: address,
    }

    struct SaleItem<phantom T0: drop> has key {
        id: 0x2::object::UID,
        price: u64,
        item: 0x1::option::Option<PuddleShares<T0>>,
    }

    struct PuddleCap<phantom T0: drop> has key {
        id: 0x2::object::UID,
        puddle_id: 0x2::object::ID,
    }

    public entry fun arbitrage<T0: drop, T1: drop>(arg0: &mut PuddleCap<T1>, arg1: &mut Puddles<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x993d82eb38d1a3ce0f952e275d2ef5e8ce7a992f3412f379f6c7c572cd65a444::admin::TeamFunds, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::object::borrow_id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3);
        let v1 = 0x2::bag::borrow_mut<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg1.investments.balance_bag, v0);
        0x1::debug::print<0x2::balance::Balance<T0>>(v1);
        assert!(arg4 <= 0x2::balance::value<T0>(v1), 14);
        let v2 = 0x993d82eb38d1a3ce0f952e275d2ef5e8ce7a992f3412f379f6c7c572cd65a444::cetus_invest::arbitrage<T0, T1>(arg2, arg3, v1, arg4, arg5, arg6);
        let v3 = *0x2::table::borrow<0x2::object::ID, u64>(&mut arg1.investments.cost_table, v0) * arg4 / 0x2::balance::value<T0>(v1);
        if (v3 < 0x2::balance::value<T1>(&v2)) {
            let v4 = 0x2::balance::value<T1>(&v2) - v3;
            0x993d82eb38d1a3ce0f952e275d2ef5e8ce7a992f3412f379f6c7c572cd65a444::admin::deposit<T1>(0x2::balance::split<T1>(&mut v2, v4 * 5 / 1000), arg7, arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v4 * (arg1.commission_percentage as u64) * 10 / 1000), arg8), arg1.metadata.trader);
            let v5 = 0x2::balance::split<T1>(&mut v2, v4 * (1000 - (arg1.commission_percentage as u64) * 10 - 5) / 1000);
            let v6 = &mut v5;
            give_out_bonus<T1>(arg1, v6, arg8);
            if (0x2::balance::value<T1>(&v5) == 0) {
                0x2::balance::destroy_zero<T1>(v5);
            } else {
                0x2::balance::join<T1>(&mut arg1.balance, v5);
            };
        };
        0x2::balance::join<T1>(&mut arg1.balance, v2);
    }

    public entry fun invest<T0: drop, T1: drop>(arg0: &mut PuddleCap<T1>, arg1: &mut Puddles<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T1>(&arg1.balance) >= arg4, 14);
        let v0 = *0x2::object::borrow_id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3);
        if (0x1::vector::contains<0x2::object::ID>(&arg1.investments.invests, &v0)) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg1.investments.cost_table, v0, 0x2::table::remove<0x2::object::ID, u64>(&mut arg1.investments.cost_table, v0) + arg4);
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg1.investments.balance_bag, v0), 0x993d82eb38d1a3ce0f952e275d2ef5e8ce7a992f3412f379f6c7c572cd65a444::cetus_invest::invest<T0, T1>(arg2, arg3, &mut arg1.balance, arg4, arg5, arg6));
            0x1::debug::print<0x2::balance::Balance<T0>>(0x2::bag::borrow_mut<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg1.investments.balance_bag, v0));
        } else {
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.investments.invests, v0);
            0x2::table::add<0x2::object::ID, u64>(&mut arg1.investments.cost_table, v0, arg4);
            0x2::bag::add<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg1.investments.balance_bag, v0, 0x993d82eb38d1a3ce0f952e275d2ef5e8ce7a992f3412f379f6c7c572cd65a444::cetus_invest::invest<T0, T1>(arg2, arg3, &mut arg1.balance, arg4, arg5, arg6));
            0x1::debug::print<0x2::balance::Balance<T0>>(0x2::bag::borrow_mut<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg1.investments.balance_bag, v0));
        };
    }

    public entry fun buy_shares<T0: drop>(arg0: &mut Puddles<T0>, arg1: &mut SaleItem<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state.is_close == false, 7);
        assert!(0x1::option::is_some<PuddleShares<T0>>(&arg1.item), 6);
        let v0 = 0x1::option::extract<PuddleShares<T0>>(&mut arg1.item);
        assert!(0x2::coin::value<T0>(arg2) >= arg1.price, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::table::remove<address, u64>(&mut arg0.holder_info.holder_amount_table, v0.owner) - v0.shares;
        if (v2 != 0) {
            0x2::table::add<address, u64>(&mut arg0.holder_info.holder_amount_table, v0.owner, v2);
        };
        0x2::table::add<address, u64>(&mut arg0.holder_info.holder_amount_table, v1, 0x2::table::remove<address, u64>(&mut arg0.holder_info.holder_amount_table, v1) + v0.shares);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.market_info.item_listing_table, 0x2::object::uid_to_inner(&arg1.id));
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.market_info.item_listing_table, 0x2::object::uid_to_inner(&arg1.id), false);
        v0.owner = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, arg1.price, arg3), v0.owner);
        0x2::transfer::public_transfer<PuddleShares<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun cancel_sale_shares<T0: drop>(arg0: &mut SaleItem<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PuddleShares<T0>>(0x1::option::extract<PuddleShares<T0>>(&mut arg0.item), 0x2::tx_context::sender(arg1));
    }

    public entry fun close_puddle<T0: drop>(arg0: &PuddleCap<T0>, arg1: &mut PuddleStatistics, arg2: &mut Puddles<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::is_empty<0x2::object::ID>(&arg2.investments.invests) == true, 11);
        assert!(arg0.puddle_id == 0x2::object::uid_to_inner(&arg2.id), 3);
        assert!(arg2.state.is_close == false, 8);
        arg2.state.is_close = true;
        let v0 = 0x2::object::uid_to_inner(&arg2.id);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&mut arg1.in_progress_puddles, &v0);
        assert!(v1, 12);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.in_progress_puddles, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.closed_puddles, 0x2::object::uid_to_inner(&arg2.id));
    }

    fun coins_to_balances<T0>(arg0: vector<0x2::coin::Coin<T0>>) : vector<0x2::balance::Balance<T0>> {
        let v0 = 0x1::vector::empty<0x2::balance::Balance<T0>>();
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0) {
            0x1::vector::push_back<0x2::balance::Balance<T0>>(&mut v0, 0x2::coin::into_balance<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0)));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public entry fun create_puddle<T0: drop>(arg0: &mut PuddleStatistics, arg1: u64, arg2: address, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = new_puddle<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = PuddleCap<T0>{
            id        : 0x2::object::new(arg6),
            puddle_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.in_progress_puddles, 0x2::object::uid_to_inner(&v0.id));
        0x2::table::add<0x2::object::ID, address>(&mut arg0.puddle_owner_table, 0x2::object::uid_to_inner(&v0.id), 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<Puddles<T0>>(v0);
        0x2::transfer::transfer<PuddleCap<T0>>(v1, arg2);
    }

    public entry fun divide_shares<T0: drop>(arg0: &mut PuddleShares<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < arg0.shares, 4);
        arg0.shares = arg0.shares - arg1;
        let v0 = PuddleShares<T0>{
            id        : 0x2::object::new(arg2),
            shares    : arg1,
            puddle_id : arg0.puddle_id,
            owner     : arg0.owner,
        };
        0x2::transfer::public_transfer<PuddleShares<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun give_out_bonus<T0: drop>(arg0: &mut Puddles<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.holder_info.holders)) {
            let v1 = *0x1::vector::borrow<address>(&mut arg0.holder_info.holders, v0);
            let v2 = 0x2::balance::value<T0>(arg1) * 0x2::table::remove<address, u64>(&mut arg0.holder_info.holder_amount_table, v1) / arg0.metadata.total_supply;
            if (0x2::balance::value<T0>(arg1) < v2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v2), arg2), v1);
                break
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v2), arg2), v1);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PuddleStatistics{
            id                  : 0x2::object::new(arg0),
            in_progress_puddles : 0x1::vector::empty<0x2::object::ID>(),
            closed_puddles      : 0x1::vector::empty<0x2::object::ID>(),
            puddle_owner_table  : 0x2::table::new<0x2::object::ID, address>(arg0),
        };
        0x2::transfer::share_object<PuddleStatistics>(v0);
    }

    public entry fun merge_shares<T0: drop>(arg0: &mut PuddleShares<T0>, arg1: PuddleShares<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let PuddleShares {
            id        : v0,
            shares    : v1,
            puddle_id : v2,
            owner     : v3,
        } = arg1;
        assert!(arg0.owner == v3, 2);
        assert!(arg0.puddle_id == v2, 3);
        arg0.shares = arg0.shares + v1;
        0x2::object::delete(v0);
    }

    public entry fun mint<T0: drop>(arg0: &mut Puddles<T0>, arg1: u64, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state.is_stop_mint == false, 9);
        assert!(arg0.state.is_close == false, 8);
        assert!(0x2::coin::value<T0>(arg2) >= arg1, 5);
        assert!(0x2::coin::value<T0>(arg2) + 0x2::balance::value<T0>(&arg0.balance) <= arg0.metadata.max_supply, 0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg1, arg3));
        arg0.metadata.total_supply = arg0.metadata.total_supply + arg1;
        if (0x2::table::contains<address, u64>(&arg0.holder_info.holder_amount_table, v0)) {
            0x2::table::add<address, u64>(&mut arg0.holder_info.holder_amount_table, v0, 0x2::table::remove<address, u64>(&mut arg0.holder_info.holder_amount_table, v0) + arg1);
        } else {
            0x1::vector::push_back<address>(&mut arg0.holder_info.holders, v0);
            0x2::table::add<address, u64>(&mut arg0.holder_info.holder_amount_table, v0, arg1);
        };
        let v2 = PuddleShares<T0>{
            id        : 0x2::object::new(arg3),
            shares    : 0x2::balance::value<T0>(&v1),
            puddle_id : 0x2::object::uid_to_inner(&arg0.id),
            owner     : 0x2::tx_context::sender(arg3),
        };
        0x2::balance::join<T0>(&mut arg0.balance, v1);
        0x2::transfer::public_transfer<PuddleShares<T0>>(v2, 0x2::tx_context::sender(arg3));
    }

    public entry fun modify_puddle_commission_percentage<T0: drop>(arg0: &PuddleCap<T0>, arg1: &mut Puddles<T0>, arg2: u8) {
        assert!(arg0.puddle_id == 0x2::object::uid_to_inner(&arg1.id), 3);
        arg1.commission_percentage = arg2;
    }

    public entry fun modify_puddle_desc<T0: drop>(arg0: &PuddleCap<T0>, arg1: &mut Puddles<T0>, arg2: 0x1::string::String) {
        assert!(arg0.puddle_id == 0x2::object::uid_to_inner(&arg1.id), 3);
        arg1.metadata.desc = arg2;
    }

    public entry fun modify_puddle_name<T0: drop>(arg0: &PuddleCap<T0>, arg1: &mut Puddles<T0>, arg2: 0x1::string::String) {
        assert!(arg0.puddle_id == 0x2::object::uid_to_inner(&arg1.id), 3);
        arg1.metadata.name = arg2;
    }

    public entry fun modify_puddle_trader<T0: drop>(arg0: &PuddleCap<T0>, arg1: &mut Puddles<T0>, arg2: address) {
        assert!(arg0.puddle_id == 0x2::object::uid_to_inner(&arg1.id), 3);
        arg1.metadata.trader = arg2;
    }

    public fun new_puddle<T0: drop>(arg0: u64, arg1: address, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Puddles<T0> {
        let v0 = HolderInfo{
            holders             : 0x1::vector::empty<address>(),
            holder_amount_table : 0x2::table::new<address, u64>(arg5),
        };
        let v1 = MarketInfo{
            items              : 0x1::vector::empty<0x2::object::ID>(),
            item_listing_table : 0x2::table::new<0x2::object::ID, bool>(arg5),
        };
        let v2 = PuddleMetaData{
            max_supply   : arg0,
            total_supply : 0,
            trader       : arg1,
            name         : 0x1::string::utf8(arg3),
            desc         : 0x1::string::utf8(arg4),
        };
        let v3 = InvestmentsRecord{
            invests       : 0x1::vector::empty<0x2::object::ID>(),
            cost_table    : 0x2::table::new<0x2::object::ID, u64>(arg5),
            balance_bag   : 0x2::bag::new(arg5),
            total_rewards : 0,
        };
        let v4 = PuddleState{
            is_close     : false,
            is_stop_mint : false,
        };
        Puddles<T0>{
            id                    : 0x2::object::new(arg5),
            balance               : 0x2::balance::zero<T0>(),
            commission_percentage : arg2,
            state                 : v4,
            holder_info           : v0,
            market_info           : v1,
            investments           : v3,
            metadata              : v2,
        }
    }

    public entry fun restart_mint<T0: drop>(arg0: &PuddleCap<T0>, arg1: &mut Puddles<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.puddle_id == 0x2::object::uid_to_inner(&arg1.id), 3);
        assert!(arg1.state.is_stop_mint == true, 10);
        arg1.state.is_stop_mint = false;
    }

    public entry fun sale_shares<T0: drop>(arg0: &mut Puddles<T0>, arg1: PuddleShares<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state.is_close == false, 7);
        let v0 = SaleItem<T0>{
            id    : 0x2::object::new(arg3),
            price : arg2,
            item  : 0x1::option::none<PuddleShares<T0>>(),
        };
        0x1::option::fill<PuddleShares<T0>>(&mut v0.item, arg1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.market_info.item_listing_table, 0x2::object::uid_to_inner(&v0.id), true);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.market_info.items, 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<SaleItem<T0>>(v0);
    }

    public entry fun stop_mint<T0: drop>(arg0: &PuddleCap<T0>, arg1: &mut Puddles<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.puddle_id == 0x2::object::uid_to_inner(&arg1.id), 3);
        assert!(arg1.state.is_stop_mint == false, 9);
        arg1.state.is_stop_mint = true;
    }

    public entry fun transfer_shares<T0: drop>(arg0: &mut Puddles<T0>, arg1: PuddleShares<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.holder_info.holder_amount_table, v0) - arg1.shares;
        if (v1 != 0) {
            0x2::table::add<address, u64>(&mut arg0.holder_info.holder_amount_table, v0, v1);
        };
        0x2::table::add<address, u64>(&mut arg0.holder_info.holder_amount_table, arg2, 0x2::table::remove<address, u64>(&mut arg0.holder_info.holder_amount_table, arg2) + arg1.shares);
        arg1.owner = arg2;
        0x2::transfer::transfer<PuddleShares<T0>>(arg1, arg2);
    }

    public entry fun withdraw_puddle_balance<T0: drop>(arg0: &PuddleCap<T0>, arg1: &mut Puddles<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state.is_close == true, 13);
        while (0 < 0x1::vector::length<address>(&arg1.holder_info.holders)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1.holder_info.holders);
            let v1 = arg1.metadata.total_supply;
            let v2 = v1 * 0x2::table::remove<address, u64>(&mut arg1.holder_info.holder_amount_table, v0) / arg1.metadata.total_supply;
            if (v1 < v2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg2), v0);
                break
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v2), arg2), v0);
        };
    }

    // decompiled from Move bytecode v6
}

