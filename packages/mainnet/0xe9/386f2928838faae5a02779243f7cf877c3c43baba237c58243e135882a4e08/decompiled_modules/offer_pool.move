module 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer_pool {
    struct OfferPool has key {
        id: 0x2::object::UID,
        rev: u64,
        owner: address,
        label: 0x1::option::Option<0x1::string::String>,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        reserved: u64,
        members: 0x2::linked_table::LinkedTable<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>,
    }

    public fun new(arg0: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg1: 0x1::option::Option<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : OfferPool {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg0);
        OfferPool{
            id       : 0x2::object::new(arg2),
            rev      : 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::rev(),
            owner    : 0x2::tx_context::sender(arg2),
            label    : arg1,
            funds    : 0x2::balance::zero<0x2::sui::SUI>(),
            reserved : 0,
            members  : 0x2::linked_table::new<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(arg2),
        }
    }

    public fun add<T0: store + key>(arg0: &mut OfferPool, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<vector<u8>>, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg1);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        only_owner(arg0, arg10);
        assert!(0x2::linked_table::length<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members) < 128, 46);
        let v0 = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::draft_terms<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::total_cost(&v0);
        assert!(v1 <= free(arg0), 32);
        arg0.reserved = arg0.reserved + v1;
        let v2 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg10));
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::announce(v2, 0x1::option::some<0x2::object::ID>(0x2::object::id<OfferPool>(arg0)), arg0.owner, &v0);
        0x2::linked_table::push_back<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&mut arg0.members, v2, v0);
        snapshot(arg0);
        v2
    }

    public fun close(arg0: OfferPool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        only_owner(&arg0, arg1);
        let v0 = 0x2::object::id<OfferPool>(&arg0);
        let OfferPool {
            id       : v1,
            rev      : _,
            owner    : v3,
            label    : _,
            funds    : v5,
            reserved : _,
            members  : v7,
        } = arg0;
        let v8 = v7;
        let v9 = v5;
        while (0x2::linked_table::length<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&v8) > 0) {
            let (v10, v11) = 0x2::linked_table::pop_back<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&mut v8);
            let v12 = v11;
            0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::bid_closed(v10, 0x1::option::some<0x2::object::ID>(v0), v3, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::units_left(&v12), 0, 3);
        };
        0x2::linked_table::destroy_empty<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(v8);
        0x2::object::delete(v1);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::pool_closed(v0, v3, 0x2::balance::value<0x2::sui::SUI>(&v9));
        0x2::coin::from_balance<0x2::sui::SUI>(v9, arg1)
    }

    public fun deposit(arg0: &mut OfferPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        snapshot(arg0);
    }

    public fun drop_member(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        release(arg0, arg1, 1);
    }

    public fun fill<T0: store + key>(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        assert!(0x2::linked_table::contains<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members, arg1), 63);
        let v0 = arg0.owner;
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&mut arg0.members, arg1);
        let v2 = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::unit_cost(v1);
        let (v3, v4, v5) = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::fill_from_kiosk<T0>(v1, &mut arg0.funds, v0, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, arg9, arg10);
        let v6 = v5;
        let v7 = *v1;
        settle(arg0, arg1, v2, &v7);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::record_hit(arg1, 0x1::option::some<0x2::object::ID>(0x2::object::id<OfferPool>(arg0)), v0, &v7, &v6, arg10);
        (v3, v4)
    }

    public fun fill_owned<T0: store + key>(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg3: T0, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        assert!(0x2::linked_table::contains<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members, arg1), 63);
        let v0 = arg0.owner;
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&mut arg0.members, arg1);
        let v2 = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::unit_cost(v1);
        let (v3, v4) = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::fill_from_wallet<T0>(v1, &mut arg0.funds, v0, arg2, arg3, &arg4, arg5, arg6);
        let v5 = v4;
        let v6 = *v1;
        settle(arg0, arg1, v2, &v6);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::record_hit(arg1, 0x1::option::some<0x2::object::ID>(0x2::object::id<OfferPool>(arg0)), v0, &v6, &v5, arg6);
        v3
    }

    public fun free(arg0: &OfferPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds) - arg0.reserved
    }

    public fun funds(arg0: &OfferPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun has_member(arg0: &OfferPool, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members, arg1)
    }

    public fun held(arg0: &OfferPool) : u64 {
        arg0.reserved
    }

    public fun maker(arg0: &OfferPool) : address {
        arg0.owner
    }

    public fun member(arg0: &OfferPool, arg1: 0x2::object::ID) : 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms {
        *0x2::linked_table::borrow<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members, arg1)
    }

    public fun member_count(arg0: &OfferPool) : u64 {
        0x2::linked_table::length<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members)
    }

    fun only_owner(arg0: &OfferPool, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 10);
    }

    public fun prune(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::linked_table::contains<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members, arg1), 63);
        assert!(0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::is_over(0x2::linked_table::borrow<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members, arg1), arg2), 24);
        release(arg0, arg1, 2);
    }

    public fun relabel(arg0: &mut OfferPool, arg1: 0x1::option::Option<0x1::string::String>, arg2: &0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        arg0.label = arg1;
        snapshot(arg0);
    }

    fun release(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: u8) {
        assert!(0x2::linked_table::contains<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members, arg1), 63);
        let v0 = 0x2::linked_table::remove<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&mut arg0.members, arg1);
        arg0.reserved = arg0.reserved - 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::total_cost(&v0);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::bid_closed(arg1, 0x1::option::some<0x2::object::ID>(0x2::object::id<OfferPool>(arg0)), arg0.owner, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::units_left(&v0), 0, arg2);
        snapshot(arg0);
    }

    fun settle(arg0: &mut OfferPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms) {
        arg0.reserved = arg0.reserved - arg2;
        if (0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::units_left(arg3) == 0) {
            0x2::linked_table::remove<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&mut arg0.members, arg1);
        };
        snapshot(arg0);
    }

    public fun share(arg0: OfferPool) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::pool_opened(0x2::object::id<OfferPool>(&arg0), arg0.owner, arg0.label);
        snapshot(&arg0);
        0x2::transfer::share_object<OfferPool>(arg0);
    }

    fun snapshot(arg0: &OfferPool) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::pool_state(0x2::object::id<OfferPool>(arg0), arg0.owner, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds), arg0.reserved, 0x2::linked_table::length<0x2::object::ID, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::offer::Terms>(&arg0.members), arg0.label);
    }

    public fun withdraw(arg0: &mut OfferPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        only_owner(arg0, arg2);
        assert!(arg1 <= free(arg0), 32);
        snapshot(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

