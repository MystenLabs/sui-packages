module 0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::asset_forwarder {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResourceSetterCap has store, key {
        id: 0x2::object::UID,
    }

    struct IRelayMessageArgsWithCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        message_hash: vector<u8>,
        forwarder: address,
        deposit_id: u256,
        min_return: u64,
        src_chain_id: vector<u8>,
        dest_token: 0x1::string::String,
        packet: vector<u8>,
        forwarder_router_address: 0x1::string::String,
        coin: 0x2::coin::Coin<T0>,
    }

    struct IRelayMessageArgsWithoutCoin has store, key {
        id: 0x2::object::UID,
        message_hash: vector<u8>,
        forwarder: address,
        deposit_id: u256,
        src_chain_id: vector<u8>,
        dest_token: 0x1::string::String,
        amount: u64,
        min_return: u64,
        forwarder_router_address: 0x1::string::String,
    }

    struct AssetForwarder has store, key {
        id: 0x2::object::UID,
        chain_id: 0x1::string::String,
        router_middleware_base: vector<u8>,
        deposit_nonce: u256,
        max_transfer_limit: u64,
        execute_record: 0x2::table::Table<vector<u8>, bool>,
        paused: bool,
        initialized: bool,
        balances: 0x2::object_bag::ObjectBag,
        users_balance: 0x2::table::Table<vector<u8>, u64>,
    }

    public(friend) fun add_withdrawable_balance(arg0: &mut AssetForwarder, arg1: vector<u8>, arg2: u64) {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.users_balance, arg1)) {
            let v0 = 0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.users_balance, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<vector<u8>, u64>(&mut arg0.users_balance, arg1, arg2);
        };
    }

    public(friend) fun borrow_mut_id(arg0: &mut AssetForwarder) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public entry fun delete_i_relay_message_args<T0>(arg0: &AssetForwarder, arg1: IRelayMessageArgsWithCoin<T0>, arg2: &0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        let IRelayMessageArgsWithCoin {
            id                       : v0,
            creator                  : v1,
            message_hash             : _,
            forwarder                : _,
            deposit_id               : _,
            min_return               : _,
            src_chain_id             : _,
            dest_token               : _,
            packet                   : _,
            forwarder_router_address : _,
            coin                     : v10,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v1 == 0x2::tx_context::sender(arg2), 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v1);
    }

    public fun executed_i_relay_message(arg0: &mut AssetForwarder, arg1: IRelayMessageArgsWithoutCoin, arg2: vector<u8>, arg3: bool) {
        when_not_paused(arg0);
        arg0.deposit_nonce = arg0.deposit_nonce + 1;
        let IRelayMessageArgsWithoutCoin {
            id                       : v0,
            message_hash             : v1,
            forwarder                : v2,
            deposit_id               : v3,
            src_chain_id             : v4,
            dest_token               : v5,
            amount                   : v6,
            min_return               : v7,
            forwarder_router_address : v8,
        } = arg1;
        0x2::object::delete(v0);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.execute_record, v1), 3);
        0x2::table::add<vector<u8>, bool>(&mut arg0.execute_record, v1, true);
        0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::events::emit_funds_paid_with_message_event(v1, v2, arg0.deposit_nonce, v3, v4, v5, v7, v6, arg2, arg3, v8);
    }

    public entry fun get_contract_balance<T0>(arg0: &AssetForwarder) : u64 {
        0x2::coin::value<T0>(0x2::object_bag::borrow<0x1::string::String, 0x2::coin::Coin<T0>>(&arg0.balances, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))))
    }

    public fun get_handler_message_args<T0>(arg0: &AssetForwarder, arg1: IRelayMessageArgsWithCoin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (IRelayMessageArgsWithoutCoin, 0x2::coin::Coin<T0>, 0x1::string::String, vector<u8>) {
        when_not_paused(arg0);
        let IRelayMessageArgsWithCoin {
            id                       : v0,
            creator                  : _,
            message_hash             : v2,
            forwarder                : v3,
            deposit_id               : v4,
            min_return               : v5,
            src_chain_id             : v6,
            dest_token               : v7,
            packet                   : v8,
            forwarder_router_address : v9,
            coin                     : v10,
        } = arg1;
        let v11 = v10;
        0x2::object::delete(v0);
        let v12 = IRelayMessageArgsWithoutCoin{
            id                       : 0x2::object::new(arg2),
            message_hash             : v2,
            forwarder                : v3,
            deposit_id               : v4,
            src_chain_id             : v6,
            dest_token               : v7,
            amount                   : 0x2::coin::value<T0>(&v11),
            min_return               : v5,
            forwarder_router_address : v9,
        };
        (v12, v11, v7, v8)
    }

    public entry fun get_user_balance<T0>(arg0: &AssetForwarder) : u64 {
        0x2::coin::value<T0>(0x2::object_bag::borrow<0x1::string::String, 0x2::coin::Coin<T0>>(&arg0.balances, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))))
    }

    public entry fun grant_role(arg0: &mut AdminCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            let v0 = AdminCap{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<AdminCap>(v0, arg2);
        } else if (arg1 == 1) {
            let v1 = ResourceSetterCap{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<ResourceSetterCap>(v1, arg2);
        } else {
            assert!(arg1 == 2, 6);
            let v2 = PauseCap{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<PauseCap>(v2, arg2);
        };
    }

    public entry fun i_deposit<T0>(arg0: &mut AssetForwarder, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: u256, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : u256 {
        when_not_paused(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        is_in_limit(arg0, v0);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::object_bag::contains<0x1::string::String>(&arg0.balances, v1)) {
            0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.balances, v1), arg1);
        } else {
            0x2::object_bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.balances, v1, arg1);
        };
        arg0.deposit_nonce = arg0.deposit_nonce + 1;
        0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::events::emit_funds_deposited_event(arg2, v0, arg5, arg3, arg0.deposit_nonce, v1, arg7, arg4, arg6);
        arg0.deposit_nonce
    }

    public entry fun i_deposit_info_fee<T0>(arg0: &mut AssetForwarder, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) : u256 {
        when_not_paused(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        is_in_limit(arg0, v0);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::object_bag::contains<0x1::string::String>(&arg0.balances, v1)) {
            0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.balances, v1), arg1);
        } else {
            0x2::object_bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.balances, v1, arg1);
        };
        arg0.deposit_nonce = arg0.deposit_nonce + 1;
        0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::events::emit_deposit_info_update_event(v1, v0, arg2, arg0.deposit_nonce, false, 0x2::tx_context::sender(arg3));
        arg0.deposit_nonce
    }

    public entry fun i_deposit_info_withdraw(arg0: &mut AssetForwarder, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : u256 {
        when_not_paused(arg0);
        arg0.deposit_nonce = arg0.deposit_nonce + 1;
        0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::events::emit_deposit_info_update_event(0x1::string::utf8(b""), 0, arg1, arg0.deposit_nonce, true, 0x2::tx_context::sender(arg2));
        arg0.deposit_nonce
    }

    public entry fun i_deposit_message<T0>(arg0: &mut AssetForwarder, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: u256, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : u256 {
        when_not_paused(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        is_in_limit(arg0, v0);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::object_bag::contains<0x1::string::String>(&arg0.balances, v1)) {
            0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.balances, v1), arg1);
        } else {
            0x2::object_bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.balances, v1, arg1);
        };
        arg0.deposit_nonce = arg0.deposit_nonce + 1;
        0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::events::emit_funds_deposited_with_message_event(arg2, v0, arg5, arg3, arg0.deposit_nonce, v1, arg7, arg4, arg6, arg8);
        arg0.deposit_nonce
    }

    public entry fun i_relay<T0>(arg0: &mut AssetForwarder, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: u256, arg5: address, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 8);
        is_in_limit(arg0, v0);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v2 = 0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::helper::get_i_relay_msg_hash(arg2, arg3, arg4, v1, arg5, 0x2::object::uid_to_bytes(&arg0.id));
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.execute_record, v2), 3);
        0x2::table::add<vector<u8>, bool>(&mut arg0.execute_record, v2, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg5);
        arg0.deposit_nonce = arg0.deposit_nonce + 1;
        0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::events::emit_funds_paid_event(v2, 0x2::tx_context::sender(arg7), arg0.deposit_nonce, arg4, arg3, v1, arg2, v0, arg6);
    }

    public entry fun i_relay_message<T0>(arg0: &mut AssetForwarder, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: u256, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 8);
        is_in_limit(arg0, v0);
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v2 = 0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::helper::get_i_relay_message_msg_hash(arg2, arg3, arg4, v1, arg5, arg6, 0x2::object::uid_to_bytes(&arg0.id));
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.execute_record, v2), 3);
        let (_, v4) = 0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::helper::get_handler_info(&arg5);
        let v5 = IRelayMessageArgsWithCoin<T0>{
            id                       : 0x2::object::new(arg8),
            creator                  : 0x2::tx_context::sender(arg8),
            message_hash             : v2,
            forwarder                : 0x2::tx_context::sender(arg8),
            deposit_id               : arg4,
            min_return               : arg2,
            src_chain_id             : arg3,
            dest_token               : v1,
            packet                   : arg6,
            forwarder_router_address : arg7,
            coin                     : arg1,
        };
        0x2::transfer::public_transfer<IRelayMessageArgsWithCoin<T0>>(v5, v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetForwarder{
            id                     : 0x2::object::new(arg0),
            chain_id               : 0x1::string::utf8(b""),
            router_middleware_base : 0x1::vector::empty<u8>(),
            deposit_nonce          : 0,
            max_transfer_limit     : 0,
            execute_record         : 0x2::table::new<vector<u8>, bool>(arg0),
            paused                 : false,
            initialized            : false,
            balances               : 0x2::object_bag::new(arg0),
            users_balance          : 0x2::table::new<vector<u8>, u64>(arg0),
        };
        let v1 = ResourceSetterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ResourceSetterCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = PauseCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PauseCap>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AssetForwarder>(v0);
    }

    public entry fun initialize(arg0: &mut AssetForwarder, arg1: &mut AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.initialized, 0);
        arg0.router_middleware_base = 0x2::hash::keccak256(0x1::string::as_bytes(&arg3));
        arg0.initialized = true;
        arg0.max_transfer_limit = arg4;
        arg0.chain_id = arg2;
    }

    fun is_in_limit(arg0: &AssetForwarder, arg1: u64) {
        assert!(arg1 <= arg0.max_transfer_limit, 5);
    }

    public entry fun pause(arg0: &mut AssetForwarder, arg1: &mut PauseCap, arg2: &0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        arg0.paused = true;
    }

    public entry fun renounce_admin_cap(arg0: AdminCap, arg1: &0x2::tx_context::TxContext) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun renounce_pause_cap(arg0: PauseCap, arg1: &0x2::tx_context::TxContext) {
        let PauseCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun renounce_resource_setter_cap(arg0: ResourceSetterCap, arg1: &0x2::tx_context::TxContext) {
        let ResourceSetterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun rescue<T0>(arg0: &mut AssetForwarder, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.balances, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(0x2::coin::value<T0>(v0) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v0, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun set_chain_id(arg0: &mut AssetForwarder, arg1: &mut ResourceSetterCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        arg0.chain_id = arg2;
    }

    public entry fun set_router_middleware_base(arg0: &mut AssetForwarder, arg1: &mut ResourceSetterCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        arg0.router_middleware_base = 0x2::hash::keccak256(0x1::string::as_bytes(&arg2));
    }

    public entry fun unpause(arg0: &mut AssetForwarder, arg1: &mut PauseCap, arg2: &0x2::tx_context::TxContext) {
        when_paused(arg0);
        arg0.paused = false;
    }

    fun when_not_paused(arg0: &AssetForwarder) {
        assert!(!arg0.paused, 1);
    }

    fun when_paused(arg0: &AssetForwarder) {
        assert!(arg0.paused, 2);
    }

    public entry fun withdraw_funds<T0>(arg0: &mut AssetForwarder, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = 0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::helper::get_user_balances_key(arg1, &v0);
        let v2 = 0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.users_balance, v1);
        assert!(*v2 >= arg2, 4);
        *v2 = *v2 - arg2;
        if (*v2 == 0) {
            0x2::table::remove<vector<u8>, u64>(&mut arg0.users_balance, v1);
        };
        let v3 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.balances, v0);
        assert!(0x2::coin::value<T0>(v3) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v3, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

