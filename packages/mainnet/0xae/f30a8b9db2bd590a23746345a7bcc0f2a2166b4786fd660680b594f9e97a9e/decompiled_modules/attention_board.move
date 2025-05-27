module 0xaef30a8b9db2bd590a23746345a7bcc0f2a2166b4786fd660680b594f9e97a9e::attention_board {
    struct BurnManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        manager: 0x2::object::ID,
    }

    struct BurnMessage<phantom T0> has copy, drop, store {
        burned_amount: u64,
        message_id: 0x1::string::String,
        message: 0x1::string::String,
    }

    public fun burn<T0>(arg0: &mut BurnManager<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = BurnMessage<T0>{
            burned_amount : v0,
            message_id    : arg2,
            message       : arg3,
        };
        0x2::event::emit<BurnMessage<T0>>(v1);
    }

    public fun burn_all<T0>(arg0: &AdminCap<T0>, arg1: &mut BurnManager<T0>, arg2: &mut 0x2::coin::TreasuryCap<T0>) {
        assert!(arg0.manager == 0x2::object::uid_to_inner(&arg1.id), 0);
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(arg2), 0x2::balance::withdraw_all<T0>(&mut arg1.balance));
    }

    public fun create_burn_manager<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnManager<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = AdminCap<T0>{
            id      : 0x2::object::new(arg0),
            manager : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::public_transfer<AdminCap<T0>>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<BurnManager<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

