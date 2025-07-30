module 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::fee_distributor {
    struct FeeReceiver has store {
        name: 0x1::ascii::String,
        percentage: 0x2::table::Table<0x1::ascii::String, u64>,
        balances: 0x2::bag::Bag,
        total_claimed: 0x2::table::Table<0x1::ascii::String, u64>,
    }

    struct FeeDistributor has key {
        id: 0x2::object::UID,
        receivers: 0x2::table::Table<0x1::ascii::String, FeeReceiver>,
        receiver_names: vector<0x1::ascii::String>,
        total_fees_collected: 0x2::table::Table<0x1::ascii::String, u64>,
        total_fees_distributed: 0x2::table::Table<0x1::ascii::String, u64>,
        admin_fees: 0x2::bag::Bag,
    }

    struct FeeReceiverAdded has copy, drop {
        name: 0x1::ascii::String,
        vault_coin_type: 0x1::ascii::String,
        percentage: u64,
    }

    struct FeeReceiverPercentageUpdated has copy, drop {
        name: 0x1::ascii::String,
        vault_coin_type: 0x1::ascii::String,
        percentage: u64,
    }

    struct FeeCollected has copy, drop {
        vault_coin_type: 0x1::ascii::String,
        fee_coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct FeeClaimed has copy, drop {
        name: 0x1::ascii::String,
        vault_coin_type: 0x1::ascii::String,
        fee_coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct FeeReceiverRemoved has copy, drop {
        name: 0x1::ascii::String,
    }

    struct FeeReceiverEnabled has copy, drop {
        name: 0x1::ascii::String,
    }

    public entry fun add_fee_receiver<T0: drop>(arg0: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::registry::AdminCap, arg1: &mut FeeDistributor, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(arg2);
        assert!(arg3 <= 10000, 0);
        if (!0x2::table::contains<0x1::ascii::String, FeeReceiver>(&arg1.receivers, v0)) {
            let v1 = FeeReceiver{
                name          : v0,
                percentage    : 0x2::table::new<0x1::ascii::String, u64>(arg4),
                balances      : 0x2::bag::new(arg4),
                total_claimed : 0x2::table::new<0x1::ascii::String, u64>(arg4),
            };
            0x2::table::add<0x1::ascii::String, FeeReceiver>(&mut arg1.receivers, v0, v1);
            0x1::vector::push_back<0x1::ascii::String>(&mut arg1.receiver_names, v0);
        };
        0x2::table::add<0x1::ascii::String, u64>(&mut 0x2::table::borrow_mut<0x1::ascii::String, FeeReceiver>(&mut arg1.receivers, v0).percentage, get_coin_type_key<T0>(), arg3);
        let v2 = FeeReceiverAdded{
            name            : v0,
            vault_coin_type : get_coin_type_key<T0>(),
            percentage      : arg3,
        };
        0x2::event::emit<FeeReceiverAdded>(v2);
    }

    public(friend) fun add_fees<T0>(arg0: 0x1::ascii::String, arg1: &mut FeeDistributor, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = get_coin_type_key<T0>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&arg1.receiver_names)) {
            let v3 = 0x2::table::borrow_mut<0x1::ascii::String, FeeReceiver>(&mut arg1.receivers, *0x1::vector::borrow<0x1::ascii::String>(&arg1.receiver_names, v2));
            if (0x2::table::contains<0x1::ascii::String, u64>(&v3.percentage, arg0)) {
                let v4 = 0x2::table::borrow<0x1::ascii::String, u64>(&v3.percentage, arg0);
                if (*v4 > 0) {
                    let v5 = v0 * *v4 / 10000;
                    if (v5 > 0) {
                        if (0x2::bag::contains<0x1::ascii::String>(&v3.balances, v1)) {
                            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v3.balances, v1), 0x2::balance::split<T0>(&mut arg2, v5));
                        } else {
                            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v3.balances, v1, 0x2::balance::split<T0>(&mut arg2, v5));
                        };
                    };
                };
            };
            v2 = v2 + 1;
        };
        if (0x2::balance::value<T0>(&arg2) > 0) {
            if (0x2::bag::contains<0x1::ascii::String>(&arg1.admin_fees, v1)) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.admin_fees, v1), arg2);
            } else {
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.admin_fees, v1, arg2);
            };
        } else {
            0x2::balance::destroy_zero<T0>(arg2);
        };
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg1.total_fees_collected, v1)) {
            let v6 = 0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg1.total_fees_collected, v1);
            *v6 = *v6 + v0;
        } else {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg1.total_fees_collected, v1, v0);
        };
        let v7 = FeeCollected{
            vault_coin_type : arg0,
            fee_coin_type   : v1,
            amount          : v0,
        };
        0x2::event::emit<FeeCollected>(v7);
    }

    public entry fun claim_admin_fees<T0>(arg0: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::registry::AdminCap, arg1: &mut FeeDistributor, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_coin_type_key<T0>();
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg1.admin_fees, v0), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.admin_fees, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_fees<T0>(arg0: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::registry::FeeCollectorCap, arg1: &mut FeeDistributor, arg2: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::registry::CapRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::registry::is_collector_cap_revoked(arg2, arg0), 6);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, FeeReceiver>(&mut arg1.receivers, 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::registry::name(arg0));
        let v1 = get_coin_type_key<T0>();
        assert!(0x2::bag::contains<0x1::ascii::String>(&v0.balances, v1), 2);
        let v2 = 0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.balances, v1);
        let v3 = 0x2::balance::value<T0>(&v2);
        assert!(v3 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg3), 0x2::tx_context::sender(arg3));
        if (0x2::table::contains<0x1::ascii::String, u64>(&v0.total_claimed, v1)) {
            let v4 = 0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut v0.total_claimed, v1);
            *v4 = *v4 + v3;
        } else {
            0x2::table::add<0x1::ascii::String, u64>(&mut v0.total_claimed, v1, v3);
        };
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg1.total_fees_distributed, v1)) {
            let v5 = 0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg1.total_fees_distributed, v1);
            *v5 = *v5 + v3;
        } else {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg1.total_fees_distributed, v1, v3);
        };
        let v6 = FeeClaimed{
            name            : 0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::registry::name(arg0),
            vault_coin_type : v1,
            fee_coin_type   : v1,
            amount          : v3,
        };
        0x2::event::emit<FeeClaimed>(v6);
    }

    public fun get_all_receiver_names(arg0: &FeeDistributor) : vector<0x1::ascii::String> {
        arg0.receiver_names
    }

    public fun get_claimable_amount<T0: drop>(arg0: &FeeDistributor, arg1: 0x1::ascii::String) : u64 {
        if (0x2::table::contains<0x1::ascii::String, FeeReceiver>(&arg0.receivers, arg1)) {
            let v1 = 0x2::table::borrow<0x1::ascii::String, FeeReceiver>(&arg0.receivers, arg1);
            let v2 = get_coin_type_key<T0>();
            if (0x2::bag::contains<0x1::ascii::String>(&v1.balances, v2)) {
                0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&v1.balances, v2))
            } else {
                0
            }
        } else {
            0
        }
    }

    fun get_coin_type_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    public fun get_total_fees_collected_for_coin_type<T0>(arg0: &FeeDistributor) : u64 {
        let v0 = get_coin_type_key<T0>();
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg0.total_fees_collected, v0)) {
            *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.total_fees_collected, v0)
        } else {
            0
        }
    }

    public fun get_total_fees_distributed_for_coin_type<T0>(arg0: &FeeDistributor) : u64 {
        let v0 = get_coin_type_key<T0>();
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg0.total_fees_distributed, v0)) {
            *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.total_fees_distributed, v0)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeDistributor{
            id                     : 0x2::object::new(arg0),
            receivers              : 0x2::table::new<0x1::ascii::String, FeeReceiver>(arg0),
            receiver_names         : 0x1::vector::empty<0x1::ascii::String>(),
            total_fees_collected   : 0x2::table::new<0x1::ascii::String, u64>(arg0),
            total_fees_distributed : 0x2::table::new<0x1::ascii::String, u64>(arg0),
            admin_fees             : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<FeeDistributor>(v0);
    }

    public entry fun remove_fee_receiver(arg0: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::registry::AdminCap, arg1: &mut FeeDistributor, arg2: vector<u8>) {
        let v0 = 0x1::ascii::string(arg2);
        assert!(0x2::table::contains<0x1::ascii::String, FeeReceiver>(&arg1.receivers, v0), 1);
        let (v1, v2) = 0x1::vector::index_of<0x1::ascii::String>(&arg1.receiver_names, &v0);
        assert!(v1, 1);
        0x1::vector::remove<0x1::ascii::String>(&mut arg1.receiver_names, v2);
        let FeeReceiver {
            name          : _,
            percentage    : v4,
            balances      : v5,
            total_claimed : v6,
        } = 0x2::table::remove<0x1::ascii::String, FeeReceiver>(&mut arg1.receivers, v0);
        let v7 = v5;
        assert!(0x2::bag::is_empty(&v7), 4);
        0x2::table::drop<0x1::ascii::String, u64>(v4);
        0x2::bag::destroy_empty(v7);
        0x2::table::drop<0x1::ascii::String, u64>(v6);
        let v8 = FeeReceiverRemoved{name: v0};
        0x2::event::emit<FeeReceiverRemoved>(v8);
    }

    public entry fun update_receiver_percentage<T0: drop>(arg0: &0x29a425252cc04cd03b7bd8d4c48e25452742346be740d4a443c0f750be3a1150::registry::AdminCap, arg1: vector<u8>, arg2: &mut FeeDistributor, arg3: u64) {
        let v0 = 0x1::ascii::string(arg1);
        let v1 = get_coin_type_key<T0>();
        assert!(arg3 <= 10000, 0);
        assert!(0x2::table::contains<0x1::ascii::String, FeeReceiver>(&arg2.receivers, v0), 1);
        *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut 0x2::table::borrow_mut<0x1::ascii::String, FeeReceiver>(&mut arg2.receivers, v0).percentage, v1) = arg3;
        let v2 = FeeReceiverPercentageUpdated{
            name            : v0,
            vault_coin_type : v1,
            percentage      : arg3,
        };
        0x2::event::emit<FeeReceiverPercentageUpdated>(v2);
    }

    // decompiled from Move bytecode v6
}

