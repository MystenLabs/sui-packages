module 0xd9c6384b0f5678f23785fe26e03e833242642a99776d256e353fc390f2060ddd::executor {
    struct Admin has key {
        id: 0x2::object::UID,
    }

    struct Caller has key {
        id: 0x2::object::UID,
    }

    struct BasePool has key {
        id: 0x2::object::UID,
        pool: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun add_callers(arg0: &Admin, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1;
        add_callers_internal(v0, arg2);
    }

    fun add_callers_internal(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(arg0)) {
            let v0 = Caller{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<Caller>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    public fun extract(arg0: &Caller, arg1: &mut BasePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<0x2::sui::SUI>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, 0x2::coin::split<0x2::sui::SUI>(&mut arg1.pool, arg2, arg3));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
        let v1 = BasePool{
            id   : 0x2::object::new(arg0),
            pool : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<BasePool>(v1);
    }

    public fun interestswap_0<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: bool, arg3: vector<0x2::coin::Coin<T0>>, arg4: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T1>> {
        let v0 = 0x2::coin::zero<T0>(arg4);
        0x2::pay::join_vec<T0>(&mut v0, arg3);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_x<T0, T1>(arg0, arg1, v0, 0, arg4));
        v1
    }

    public fun interestswap_1<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: bool, arg3: vector<0x2::coin::Coin<T1>>, arg4: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x2::coin::zero<T1>(arg4);
        0x2::pay::join_vec<T1>(&mut v0, arg3);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_y<T0, T1>(arg0, arg1, v0, 0, arg4));
        v1
    }

    public fun theshhold_check_and_transferback(arg0: &Caller, arg1: &mut BasePool, arg2: u64, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) > arg2, 0);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, v0);
    }

    public entry fun transfer_in_to_base_pool(arg0: &Admin, arg1: &mut BasePool, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        transfer_in_to_base_pool_internal(arg1, arg2);
    }

    fun transfer_in_to_base_pool_internal(arg0: &mut BasePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.pool, arg1);
    }

    public entry fun transfer_out_from_base_pool(arg0: &Admin, arg1: &mut BasePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        transfer_out_from_base_pool_internal(arg1, arg2, arg3);
    }

    fun transfer_out_from_base_pool_internal(arg0: &mut BasePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg0.pool, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

