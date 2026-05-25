module 0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::rebate {
    struct RebateRegistry has store, key {
        id: 0x2::object::UID,
        roots: 0x2::table::Table<u64, vector<u8>>,
        claimed: 0x2::table::Table<u64, 0x2::table::Table<vector<u8>, bool>>,
        vault: 0x2::bag::Bag,
    }

    struct RebateClaimed has copy, drop {
        user: address,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
        epoch_id: u64,
    }

    struct RootUpdated has copy, drop {
        epoch_id: u64,
        root: vector<u8>,
    }

    public fun claim_rebate<T0>(arg0: &mut RebateRegistry, arg1: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<u64, vector<u8>>(&arg0.roots, arg2), 3);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x2::bcs::to_bytes<address>(&v0);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&v1));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg2));
        let v3 = 0x1::hash::sha3_256(v2);
        let v4 = 0x2::table::borrow_mut<u64, 0x2::table::Table<vector<u8>, bool>>(&mut arg0.claimed, arg2);
        assert!(!0x2::table::contains<vector<u8>, bool>(v4, v3), 1);
        assert!(verify_merkle_proof(*0x2::table::borrow<u64, vector<u8>>(&arg0.roots, arg2), arg4, v3), 0);
        0x2::table::add<vector<u8>, bool>(v4, v3, true);
        let v5 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v5), 2);
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v5);
        assert!(0x2::balance::value<T0>(v6) >= arg3, 2);
        let v7 = RebateClaimed{
            user       : v0,
            asset_type : v1,
            amount     : arg3,
            epoch_id   : arg2,
        };
        0x2::event::emit<RebateClaimed>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, arg3), arg5)
    }

    fun deposit_to_vault<T0>(arg0: &mut RebateRegistry, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun deposit_to_vault_public<T0>(arg0: &mut RebateRegistry, arg1: 0x2::coin::Coin<T0>) {
        deposit_to_vault<T0>(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RebateRegistry{
            id      : 0x2::object::new(arg0),
            roots   : 0x2::table::new<u64, vector<u8>>(arg0),
            claimed : 0x2::table::new<u64, 0x2::table::Table<vector<u8>, bool>>(arg0),
            vault   : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<RebateRegistry>(v0);
    }

    fun is_less_than(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 != 0x1::vector::length<u8>(arg1)) {
            return v0 < 0x1::vector::length<u8>(arg1)
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) < *0x1::vector::borrow<u8>(arg1, v1)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(arg0, v1) > *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun pull_from_pool<T0, T1>(arg0: &mut RebateRegistry, arg1: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_rebate_manager_role(arg1, 0x2::tx_context::sender(arg4));
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::claim_pool_referral_rewards<T0, T1>(arg2, arg3, arg4);
        deposit_to_vault<T0>(arg0, v0);
        deposit_to_vault<T1>(arg0, v1);
        deposit_to_vault<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, v2);
    }

    public fun set_root(arg0: &mut RebateRegistry, arg1: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_rebate_manager_role(arg1, 0x2::tx_context::sender(arg4));
        if (0x2::table::contains<u64, vector<u8>>(&arg0.roots, arg2)) {
            *0x2::table::borrow_mut<u64, vector<u8>>(&mut arg0.roots, arg2) = arg3;
        } else {
            0x2::table::add<u64, vector<u8>>(&mut arg0.roots, arg2, arg3);
            0x2::table::add<u64, 0x2::table::Table<vector<u8>, bool>>(&mut arg0.claimed, arg2, 0x2::table::new<vector<u8>, bool>(arg4));
        };
        let v0 = RootUpdated{
            epoch_id : arg2,
            root     : arg3,
        };
        0x2::event::emit<RootUpdated>(v0);
    }

    fun verify_merkle_proof(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<u8>) : bool {
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg1, v1);
            let v3 = if (is_less_than(&v0, &v2)) {
                let v4 = v0;
                0x1::vector::append<u8>(&mut v4, v2);
                0x1::hash::sha3_256(v4)
            } else {
                0x1::vector::append<u8>(&mut v2, v0);
                0x1::hash::sha3_256(v2)
            };
            v0 = v3;
            v1 = v1 + 1;
        };
        v0 == arg0
    }

    // decompiled from Move bytecode v6
}

