module 0x5b7772033302df3ea06eec0b65a4140468f6ad57db01cfc88ca7dbb85b4e42db::fundv3 {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DepositEvent has copy, drop {
        uid: u64,
        sender: address,
        coin_type: 0x1::string::String,
        amount: u64,
        deposit_num: u64,
    }

    struct WithdrawEvent has copy, drop {
        uid: u64,
        receiver: address,
        coin_type: 0x1::string::String,
        amount: u64,
        nonce: u64,
        withdraw_num: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        admin: address,
        public_keys: vector<vector<u8>>,
        threshold: u64,
        chain_id: u64,
        used_nonces: 0x2::table::Table<u64, bool>,
        deposit_enabled: bool,
        withdraw_enabled: bool,
        total_deposits: u64,
        total_withdrawals: u64,
    }

    public entry fun add_public_key(arg0: &mut Config, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.public_keys)) {
            assert!(*0x1::vector::borrow<vector<u8>>(&arg0.public_keys, v0) != arg1, 5);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<vector<u8>>(&mut arg0.public_keys, arg1);
    }

    fun check_duplicate_signatures(arg0: &vector<vector<u8>>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<vector<u8>>(arg0, v1);
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(*v2 != *0x1::vector::borrow<vector<u8>>(arg0, v3), 11);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun create_withdraw_message(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x2::hash::blake2b256(&v0)
    }

    public entry fun deposit<T0>(arg0: &mut Config, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deposit_enabled, 13);
        let v0 = vault_key<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            let v1 = Vault<T0>{
                id      : 0x2::object::new(arg4),
                balance : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_field::add<0x1::type_name::TypeName, Vault<T0>>(&mut arg0.id, v0, v1);
        };
        let v2 = merge_coins<T0>(arg2, arg4);
        0x2::coin::put<T0>(&mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Vault<T0>>(&mut arg0.id, v0).balance, 0x2::coin::split<T0>(&mut v2, arg3, arg4));
        arg0.total_deposits = arg0.total_deposits + 1;
        let v3 = DepositEvent{
            uid         : arg1,
            sender      : 0x2::tx_context::sender(arg4),
            coin_type   : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount      : arg3,
            deposit_num : arg0.total_deposits,
        };
        0x2::event::emit<DepositEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun get_admin(arg0: &Config) : address {
        arg0.admin
    }

    public fun get_balance<T0>(arg0: &Config) : u64 {
        let v0 = vault_key<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 10);
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<0x1::type_name::TypeName, Vault<T0>>(&arg0.id, v0).balance)
    }

    public fun get_deposit_enabled(arg0: &Config) : bool {
        arg0.deposit_enabled
    }

    public fun get_keys_count(arg0: &Config) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.public_keys)
    }

    public fun get_public_keys(arg0: &Config) : vector<vector<u8>> {
        arg0.public_keys
    }

    public fun get_threshold(arg0: &Config) : u64 {
        arg0.threshold
    }

    public fun get_total_deposits(arg0: &Config) : u64 {
        arg0.total_deposits
    }

    public fun get_total_withdrawals(arg0: &Config) : u64 {
        arg0.total_withdrawals
    }

    public fun get_withdraw_enabled(arg0: &Config) : bool {
        arg0.withdraw_enabled
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            admin             : 0x2::tx_context::sender(arg0),
            public_keys       : 0x1::vector::empty<vector<u8>>(),
            threshold         : 1,
            chain_id          : 1,
            used_nonces       : 0x2::table::new<u64, bool>(arg0),
            deposit_enabled   : true,
            withdraw_enabled  : true,
            total_deposits    : 0,
            total_withdrawals : 0,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun init_signer(arg0: &mut Config, arg1: vector<u8>, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        only_owner(arg0, arg4);
        add_public_key(arg0, arg1, arg4);
        arg0.admin = arg2;
        arg0.chain_id = arg3;
    }

    fun is_nonce_used(arg0: &Config, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.used_nonces, arg1)
    }

    fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg1);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    fun only_admin(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 9);
    }

    fun only_owner(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 8);
    }

    public entry fun remove_public_key(arg0: &mut Config, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.public_keys)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg0.public_keys, v0) == arg1) {
                0x1::vector::remove<vector<u8>>(&mut arg0.public_keys, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 4);
        let v2 = 0x1::vector::length<vector<u8>>(&arg0.public_keys);
        if (v2 < arg0.threshold && v2 > 0) {
            arg0.threshold = v2;
        };
    }

    public entry fun set_deposit_enabled(arg0: &mut Config, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        arg0.deposit_enabled = arg1;
    }

    public entry fun set_withdraw_enabled(arg0: &mut Config, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        arg0.withdraw_enabled = arg1;
    }

    public entry fun update_threshold(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 9);
        assert!(arg1 > 0, 6);
        assert!(arg1 <= 0x1::vector::length<vector<u8>>(&arg0.public_keys), 6);
        arg0.threshold = arg1;
    }

    public fun vault_exists<T0>(arg0: &Config) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, vault_key<T0>())
    }

    fun vault_key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    fun verify_multisig(arg0: &Config, arg1: vector<vector<u8>>, arg2: vector<u8>) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg0.public_keys);
        let v1 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v0 > 0, 4);
        assert!(v1 > 0, 1);
        assert!(v1 <= v0, 1);
        if (v1 > 1) {
            check_duplicate_signatures(&arg1);
        };
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<vector<u8>>(&arg1, v4);
            assert!(0x1::vector::length<u8>(v5) == 64, 3);
            let v6 = 0;
            while (v6 < v0) {
                let v7 = 0x1::vector::borrow<vector<u8>>(&arg0.public_keys, v6);
                if (!0x1::vector::contains<u64>(&v3, &v6) && 0x2::ed25519::ed25519_verify(v5, v7, &arg2)) {
                    v2 = v2 + 1;
                    0x1::vector::push_back<u64>(&mut v3, v6);
                    break
                };
                v6 = v6 + 1;
            };
            v4 = v4 + 1;
        };
        assert!(v2 >= arg0.threshold, 7);
    }

    public entry fun withdraw_multisig<T0>(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.withdraw_enabled, 14);
        assert!(!is_nonce_used(arg0, arg3), 12);
        verify_multisig(arg0, arg5, create_withdraw_message(arg4, arg1, arg2, arg3, arg0.chain_id));
        0x2::table::add<u64, bool>(&mut arg0.used_nonces, arg3, true);
        arg0.total_withdrawals = arg0.total_withdrawals + 1;
        let v0 = WithdrawEvent{
            uid          : arg1,
            receiver     : arg4,
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            amount       : arg2,
            nonce        : arg3,
            withdraw_num : arg0.total_withdrawals,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        let v1 = vault_key<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1), 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Vault<T0>>(&mut arg0.id, v1).balance, arg2, arg6), arg4);
    }

    // decompiled from Move bytecode v6
}

