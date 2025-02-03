module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::vault {
    struct Vault has store {
        id: 0x2::object::UID,
        allowlist: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::Allowlist,
        spending_limits: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::spending_limit::SpendingLimitBook,
    }

    struct DepositCoinEvent<phantom T0> has copy, drop {
        vault: 0x2::object::ID,
        asset_key: 0x1::ascii::String,
        amount: u64,
    }

    struct TransferCoinEvent<phantom T0> has copy, drop {
        vault: 0x2::object::ID,
        asset_key: 0x1::ascii::String,
        to: address,
        amount: u64,
    }

    struct TransferCoinToVaultEvent<phantom T0> has copy, drop {
        vault: 0x2::object::ID,
        asset_key: 0x1::ascii::String,
        to_vault: 0x2::object::ID,
        amount: u64,
    }

    struct DepositObjectEvent<phantom T0> has copy, drop {
        vault: 0x2::object::ID,
        asset_key: 0x2::object::ID,
    }

    struct TransferObjectEvent<phantom T0> has copy, drop {
        vault: 0x2::object::ID,
        asset_key: 0x2::object::ID,
        to: address,
    }

    struct TransferObjectToMavenVaultEvent<phantom T0> has copy, drop {
        vault: 0x2::object::ID,
        asset_key: 0x2::object::ID,
        to_vault: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id              : 0x2::object::new(arg0),
            allowlist       : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::new(arg0),
            spending_limits : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::spending_limit::new(arg0),
        }
    }

    public(friend) fun spend<T0>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::coin_key<T0>();
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::spending_limit::spend(&mut arg0.spending_limits, 0x2::tx_context::sender(arg5), v0, arg1, arg3, arg4);
        transfer_coin_unsafe<T0>(arg0, v0, arg2, arg3, arg5);
    }

    fun coin_precheck<T0>(arg0: &Vault, arg1: 0x1::ascii::String, arg2: address, arg3: u64) : (bool, u64) {
        if (!0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::is_coin_allowed(&arg0.allowlist, arg1, arg2)) {
            return (false, 1003)
        };
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::coin_key<T0>() == arg1, 1011);
        let (v0, v1) = exist_coin<T0>(arg0);
        if (!v0) {
            return (false, 1012)
        };
        if (v1 < arg3) {
            return (false, 1009)
        };
        (true, 0)
    }

    public fun deposit_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::coin_key<T0>();
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0)) {
            0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        } else {
            0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        };
        let v1 = DepositCoinEvent<0x2::coin::Coin<T0>>{
            vault     : 0x2::object::uid_to_inner(&arg0.id),
            asset_key : v0,
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositCoinEvent<0x2::coin::Coin<T0>>>(v1);
    }

    public fun deposit_object<T0: store + key>(arg0: &mut Vault, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        let v1 = DepositObjectEvent<T0>{
            vault     : 0x2::object::uid_to_inner(&arg0.id),
            asset_key : v0,
        };
        0x2::event::emit<DepositObjectEvent<T0>>(v1);
    }

    public(friend) fun execute_allowlist(arg0: &mut Vault, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::execute(&mut arg0.allowlist, arg1);
    }

    public(friend) fun execute_coin<T0>(arg0: &mut Vault, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_coin_operation(arg1), 1001);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::is_coin_transfer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1)), 1002);
        execute_coin_transfer<T0>(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::deserialize_coin_transfer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)), arg2);
    }

    public fun execute_coin_precheck<T0>(arg0: &Vault, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) : (bool, u64) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_coin_operation(arg1), 1001);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::is_coin_transfer(v0)) {
            let (v3, v4, v5) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::coin_transfer_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::deserialize_coin_transfer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
            coin_precheck<T0>(arg0, v3, v4, v5)
        } else if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::is_coin_transfer_to_maven_vault(v0)) {
            let (v6, _, v8, v9) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::coin_transfer_to_maven_vault_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::deserialize_coin_transfer_to_maven_vault(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
            let v10 = v8;
            coin_precheck<T0>(arg0, v6, 0x2::object::id_to_address(&v10), v9)
        } else {
            (false, 1002)
        }
    }

    public(friend) fun execute_coin_to_maven_vault<T0>(arg0: &mut Vault, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: 0x2::object::ID, arg3: &mut Vault, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_coin_operation(arg1), 1001);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::is_coin_transfer_to_maven_vault(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1)), 1002);
        let (v0, v1, v2, v3) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::coin_transfer_to_maven_vault_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::deserialize_coin_transfer_to_maven_vault(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        assert!(arg2 == v1, 1014);
        transfer_coin_to_maven_vault_safe<T0>(arg0, v0, v2, v3, arg3, arg4);
    }

    fun execute_coin_transfer<T0>(arg0: &mut Vault, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::CoinTransfer, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::coin_operation::coin_transfer_destruct(arg1);
        transfer_coin_safe<T0>(arg0, v0, v1, v2, arg2);
    }

    public(friend) fun execute_object<T0: store + key>(arg0: &mut Vault, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_object_operation(arg1), 1004);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::is_object_transfer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1)), 1005);
        execute_object_transfer<T0>(arg0, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::deserialize_object_transfer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
    }

    public fun execute_object_precheck(arg0: &Vault, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &mut 0x2::vec_set::VecSet<0x2::object::ID>) : (bool, u64) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_object_operation(arg1), 1004);
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::is_object_transfer(v0)) {
            let (v1, v2) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::object_transfer_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::deserialize_object_transfer(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
            return object_precheck(arg0, v1, v2, arg2)
        };
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::is_object_transfer_to_maven_vault(v0)) {
            let (v3, _, v5) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::object_transfer_to_maven_vault_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::deserialize_object_transfer_to_maven_vault(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
            let v6 = v5;
            return object_precheck(arg0, v3, 0x2::object::id_to_address(&v6), arg2)
        };
        (false, 1005)
    }

    fun execute_object_transfer<T0: store + key>(arg0: &mut Vault, arg1: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::ObjectTransfer) {
        let (v0, v1) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::object_transfer_destruct(arg1);
        transfer_object<T0>(arg0, v0, v1);
    }

    public(friend) fun execute_object_transfer_to_maven_vault<T0: store + key>(arg0: &mut Vault, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: 0x2::object::ID, arg3: &mut Vault) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::is_object_operation(arg1), 1004);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::is_object_transfer_to_maven_vault(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_sub_type(arg1)), 1005);
        let (v0, v1, v2) = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::object_transfer_to_maven_vault_destruct(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::object_operation::deserialize_object_transfer_to_maven_vault(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_op_data(arg1)));
        assert!(v1 == arg2, 1014);
        transfer_object_to_maven_vault<T0>(arg0, v0, v2, arg3);
    }

    public(friend) fun execute_spending_limit(arg0: &mut Vault, arg1: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::spending_limit::execute(&mut arg0.spending_limits, arg1, arg2, arg3);
    }

    public fun exist_coin<T0>(arg0: &Vault) : (bool, u64) {
        let v0 = 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::coin_key<T0>();
        if (0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, 0x2::coin::Coin<T0>>(&arg0.id, v0)) {
            (true, 0x2::coin::value<T0>(0x2::dynamic_object_field::borrow<0x1::ascii::String, 0x2::coin::Coin<T0>>(&arg0.id, v0)))
        } else {
            (false, 0)
        }
    }

    public fun exist_object_any(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public fun exist_object_with_type<T0: store + key>(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, T0>(&arg0.id, arg1)
    }

    public fun get_allowlist_rd(arg0: &Vault) : &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::Allowlist {
        &arg0.allowlist
    }

    public fun get_spending_limit_rd(arg0: &Vault) : &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::spending_limit::SpendingLimitBook {
        &arg0.spending_limits
    }

    fun object_precheck(arg0: &Vault, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::vec_set::VecSet<0x2::object::ID>) : (bool, u64) {
        if (0x2::vec_set::contains<0x2::object::ID>(arg3, &arg1)) {
            return (false, 1015)
        };
        0x2::vec_set::insert<0x2::object::ID>(arg3, arg1);
        if (!0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::is_object_allowed(&arg0.allowlist, arg1, arg2)) {
            return (false, 1003)
        };
        if (!exist_object_any(arg0, arg1)) {
            return (false, 1010)
        };
        (true, 0)
    }

    fun transfer_coin_safe<T0>(arg0: &mut Vault, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::is_coin_allowed(&arg0.allowlist, arg1, arg2), 1003);
        transfer_coin_unsafe<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun transfer_coin_to_maven_vault_safe<T0>(arg0: &mut Vault, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut Vault, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg4.id) == arg2, 1013);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::is_coin_allowed(&arg0.allowlist, arg1, 0x2::object::id_to_address(&arg2)), 1003);
        transfer_coin_to_maven_vault_unsafe<T0>(arg0, arg1, arg4, arg3, arg5);
    }

    fun transfer_coin_to_maven_vault_unsafe<T0>(arg0: &mut Vault, arg1: 0x1::ascii::String, arg2: &mut Vault, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::coin_key<T0>() == arg1, 1011);
        let (v0, v1) = exist_coin<T0>(arg0);
        assert!(v0, 1012);
        assert!(v1 >= arg3, 1009);
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg2.id, arg1)) {
            0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg2.id, arg1, 0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg3, arg4));
        } else {
            0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg2.id, arg1), 0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg3, arg4));
        };
        let v2 = TransferCoinToVaultEvent<0x2::coin::Coin<T0>>{
            vault     : 0x2::object::uid_to_inner(&arg0.id),
            asset_key : arg1,
            to_vault  : 0x2::object::uid_to_inner(&arg2.id),
            amount    : arg3,
        };
        0x2::event::emit<TransferCoinToVaultEvent<0x2::coin::Coin<T0>>>(v2);
    }

    fun transfer_coin_unsafe<T0>(arg0: &mut Vault, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::utils::coin_key<T0>() == arg1, 1011);
        let (v0, v1) = exist_coin<T0>(arg0);
        assert!(v0, 1012);
        assert!(v1 >= arg3, 1009);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg3, arg4), arg2);
        let v2 = TransferCoinEvent<0x2::coin::Coin<T0>>{
            vault     : 0x2::object::uid_to_inner(&arg0.id),
            asset_key : arg1,
            to        : arg2,
            amount    : arg3,
        };
        0x2::event::emit<TransferCoinEvent<0x2::coin::Coin<T0>>>(v2);
    }

    fun transfer_object<T0: store + key>(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: address) {
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::is_object_allowed(&arg0.allowlist, arg1, arg2), 1003);
        assert!(exist_object_with_type<T0>(arg0, arg1), 1010);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1), arg2);
        let v0 = TransferObjectEvent<T0>{
            vault     : 0x2::object::uid_to_inner(&arg0.id),
            asset_key : arg1,
            to        : arg2,
        };
        0x2::event::emit<TransferObjectEvent<T0>>(v0);
    }

    fun transfer_object_to_maven_vault<T0: store + key>(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut Vault) {
        assert!(arg2 != 0x2::object::uid_to_inner(&arg0.id), 1013);
        assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::allowlist::is_object_allowed(&arg0.allowlist, arg1, 0x2::object::id_to_address(&arg2)), 1003);
        assert!(exist_object_with_type<T0>(arg0, arg1), 1010);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg3.id, arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1));
        let v0 = TransferObjectToMavenVaultEvent<T0>{
            vault     : 0x2::object::uid_to_inner(&arg0.id),
            asset_key : arg1,
            to_vault  : arg2,
        };
        0x2::event::emit<TransferObjectToMavenVaultEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

