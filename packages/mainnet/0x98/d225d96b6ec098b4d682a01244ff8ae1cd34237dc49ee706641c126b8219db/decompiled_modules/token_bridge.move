module 0x98d225d96b6ec098b4d682a01244ff8ae1cd34237dc49ee706641c126b8219db::token_bridge {
    struct StateObject<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        tx_records: 0x2::table::Table<0x1::string::String, address>,
    }

    struct DevAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TransferEvent has copy, drop {
        recipient: address,
        amount: u64,
        tx_hash: 0x1::string::String,
        sender: address,
        coin_type: 0x1::string::String,
    }

    public fun add_funds<T0>(arg0: &mut StateObject<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun check_tx_hash_exists<T0>(arg0: &StateObject<T0>, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.tx_records, arg1)
    }

    public fun destroy_empty_state<T0>(arg0: StateObject<T0>) {
        let StateObject {
            id         : v0,
            balance    : v1,
            tx_records : v2,
        } = arg0;
        let v3 = v1;
        assert!(0x2::balance::value<T0>(&v3) == 0, 1);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::table::destroy_empty<0x1::string::String, address>(v2);
        0x2::object::delete(v0);
    }

    public fun emergency_withdraw<T0>(arg0: &mut StateObject<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.balance) > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun get_pool_balance<T0>(arg0: &StateObject<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_tx_records_count<T0>(arg0: &StateObject<T0>) : u64 {
        0x2::table::length<0x1::string::String, address>(&arg0.tx_records)
    }

    public fun get_tx_sender<T0>(arg0: &StateObject<T0>, arg1: 0x1::string::String) : address {
        *0x2::table::borrow<0x1::string::String, address>(&arg0.tx_records, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DevAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DevAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_token_bridge<T0>(arg0: &DevAdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StateObject<T0>{
            id         : 0x2::object::new(arg2),
            balance    : 0x2::coin::into_balance<T0>(arg1),
            tx_records : 0x2::table::new<0x1::string::String, address>(arg2),
        };
        0x2::transfer::transfer<StateObject<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun transfer_token<T0>(arg0: &mut StateObject<T0>, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        assert!(0x1::string::length(&arg3) > 0, 4);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.tx_records, arg3), 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 1);
        0x2::table::add<0x1::string::String, address>(&mut arg0.tx_records, arg3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg4), arg1);
        let v0 = TransferEvent{
            recipient : arg1,
            amount    : arg2,
            tx_hash   : arg3,
            sender    : 0x2::tx_context::sender(arg4),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

