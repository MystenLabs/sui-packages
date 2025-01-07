module 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::vault {
    struct VaultStore has store, key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<u64, 0x2::object::ID>,
        index: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        manager: address,
        index: u64,
        name: 0x1::string::String,
        type: u8,
        users: vector<address>,
        sequence_number: u128,
    }

    public entry fun add_users(arg0: &0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::ProtocolConfig, arg1: &mut Vault, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::verify_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.manager, 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::errors::unauthorized());
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v2 = 0x1::vector::borrow<address>(&arg2, v0);
            if (!0x1::vector::contains<address>(&arg1.users, v2)) {
                0x1::vector::push_back<address>(&mut arg1.users, *v2);
                0x1::vector::push_back<address>(&mut v1, *v2);
            };
            v0 = v0 + 1;
        };
        arg1.sequence_number = arg1.sequence_number + 1;
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::events::emit_vault_users_added_event(0x2::object::id<Vault>(arg1), v1, arg1.sequence_number);
    }

    public entry fun create_vault(arg0: &0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::ProtocolConfig, arg1: &mut VaultStore, arg2: address, arg3: vector<u8>, arg4: u8, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::verify_version(arg0);
        let v0 = Vault{
            id              : 0x2::object::new(arg6),
            manager         : arg2,
            index           : arg1.index,
            name            : 0x1::string::utf8(arg3),
            type            : arg4,
            users           : arg5,
            sequence_number : 0,
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.vaults, arg1.index, v1);
        arg1.index = arg1.index + 1;
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::events::emit_vault_created_event(v1, v0.manager, v0.name, v0.type, v0.index);
        0x2::transfer::share_object<Vault>(v0);
    }

    fun get_balance_of_amount<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, get_coin_type<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::errors::insufficient_funds());
        0x2::balance::split<T0>(v0, arg1)
    }

    fun get_coin_reserves<T0>(arg0: &0x2::object::UID) : u64 {
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, get_coin_type<T0>()))
    }

    fun get_coin_type<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public(friend) fun get_mutable_id(arg0: &mut Vault, arg1: &0x2::tx_context::TxContext) : &mut 0x2::object::UID {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.users, &v0) || arg0.manager == v0, 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::errors::unauthorized());
        &mut arg0.id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultStore{
            id     : 0x2::object::new(arg0),
            vaults : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            index  : 0,
        };
        0x2::transfer::share_object<VaultStore>(v0);
    }

    public entry fun provide_funds<T0>(arg0: &0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::ProtocolConfig, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::verify_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::errors::zero_coin_amount());
        let v1 = get_coin_type<T0>();
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v1)) {
            0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.id, v1, 0x2::balance::zero<T0>());
        };
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.id, v1);
        arg1.sequence_number = arg1.sequence_number + 1;
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::events::emit_funds_provided_event(0x2::object::id<Vault>(arg1), 0x2::tx_context::sender(arg3), v1, v0, 0x2::balance::value<T0>(v2), 0x2::balance::join<T0>(v2, 0x2::coin::into_balance<T0>(arg2)), arg1.sequence_number);
    }

    public entry fun remove_users(arg0: &0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::ProtocolConfig, arg1: &mut Vault, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::verify_version(arg0);
        verify_user(arg1, arg3);
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v2 = 0x1::vector::borrow<address>(&arg2, v0);
            let (v3, v4) = 0x1::vector::index_of<address>(&arg1.users, v2);
            if (v3) {
                0x1::vector::remove<address>(&mut arg1.users, v4);
                0x1::vector::push_back<address>(&mut v1, *v2);
            };
            v0 = v0 + 1;
        };
        arg1.sequence_number = arg1.sequence_number + 1;
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::events::emit_vault_users_removed_event(0x2::object::id<Vault>(arg1), v1, arg1.sequence_number);
    }

    public(friend) fun request_funds<T0>(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        verify_user(arg0, arg2);
        let v0 = get_coin_reserves<T0>(&arg0.id);
        let v1 = if (arg1 == 0) {
            0x2::balance::zero<T0>()
        } else {
            get_balance_of_amount<T0>(arg0, arg1)
        };
        arg0.sequence_number = arg0.sequence_number + 1;
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::events::emit_funds_requested_event(0x2::object::id<Vault>(arg0), 0x2::tx_context::sender(arg2), get_coin_type<T0>(), arg1, v0, get_coin_reserves<T0>(&arg0.id), arg0.sequence_number);
        v1
    }

    public(friend) fun return_funds_to_reserves<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        verify_user(arg0, arg2);
        let v0 = get_coin_type<T0>();
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::events::emit_funds_returned_event(0x2::object::id<Vault>(arg0), 0x2::tx_context::sender(arg2), v0, 0x2::balance::value<T0>(&arg1), 0x2::balance::value<T0>(v1), 0x2::balance::join<T0>(v1, arg1), arg0.sequence_number);
    }

    public fun verify_manager(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.manager == 0x2::tx_context::sender(arg1), 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::errors::unauthorized());
    }

    public fun verify_user(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.users, &v0), 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::errors::unauthorized());
    }

    public entry fun withdraw_funds<T0>(arg0: &0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::ProtocolConfig, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::admin::verify_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.manager, 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::errors::unauthorized());
        assert!(arg2 > 0, 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::errors::zero_coin_amount());
        let v1 = get_coin_type<T0>();
        let v2 = if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v1)) {
            0
        } else {
            get_coin_reserves<T0>(&arg1.id)
        };
        let v3 = get_balance_of_amount<T0>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg3), v0);
        arg1.sequence_number = arg1.sequence_number + 1;
        0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::events::emit_funds_withdrawn_event(0x2::object::id<Vault>(arg1), v1, arg2, v2, get_coin_reserves<T0>(&arg1.id), arg1.sequence_number);
    }

    // decompiled from Move bytecode v6
}

