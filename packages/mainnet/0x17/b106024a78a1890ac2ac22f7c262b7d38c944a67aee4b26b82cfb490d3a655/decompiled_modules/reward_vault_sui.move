module 0xd94252d8e5f5561ada000d29bb6437d2f45d94811099d3d230ce87ee56a89cab::reward_vault_sui {
    struct RewardVault has key {
        id: 0x2::object::UID,
        signers: 0x2::vec_set::VecSet<vector<u8>>,
        owner: address,
        used_payment_ids: 0x2::vec_set::VecSet<u64>,
    }

    struct CoinType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardVaultCreatedEvent has copy, drop, store {
        reward_vault_id: address,
        owner: address,
        signers: vector<vector<u8>>,
    }

    struct TokenDepositedEvent has copy, drop, store {
        payment_id: u64,
        project_id: u64,
        token: 0x1::ascii::String,
        amount: u64,
        deadline: u64,
    }

    struct TokenWithdrawalEvent has copy, drop, store {
        payment_id: u64,
        project_id: u64,
        token: 0x1::ascii::String,
        amount: u64,
        recipient: address,
        deadline: u64,
    }

    struct RewardsClaimedEvent has copy, drop, store {
        payment_id: u64,
        project_id: u64,
        token: 0x1::ascii::String,
        amount: u64,
        recipient: address,
        deadline: u64,
    }

    public fun claim<T0>(arg0: &mut RewardVault, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        validate(arg0, arg1, arg2, arg3, v0, arg4, arg5, arg6, arg7);
        let v1 = CoinType<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinType<T0>>(&arg0.id, v1), 5);
        let v2 = 0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v1);
        assert!(0x2::coin::value<T0>(v2) >= arg4, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v2, arg4, arg8), arg3);
        let v3 = RewardsClaimedEvent{
            payment_id : arg1,
            project_id : arg2,
            token      : v0,
            amount     : arg4,
            recipient  : arg3,
            deadline   : arg5,
        };
        0x2::event::emit<RewardsClaimedEvent>(v3);
    }

    public fun create_reward_vault(arg0: vector<vector<u8>>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<vector<u8>>();
        while (!0x1::vector::is_empty<vector<u8>>(&arg0)) {
            0x2::vec_set::insert<vector<u8>>(&mut v0, 0x1::vector::pop_back<vector<u8>>(&mut arg0));
        };
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = RewardVault{
            id               : 0x2::object::new(arg1),
            signers          : v0,
            owner            : v1,
            used_payment_ids : 0x2::vec_set::empty<u64>(),
        };
        0x2::transfer::share_object<RewardVault>(v2);
        let v3 = RewardVaultCreatedEvent{
            reward_vault_id : 0x2::object::id_address<RewardVault>(&v2),
            owner           : v1,
            signers         : arg0,
        };
        0x2::event::emit<RewardVaultCreatedEvent>(v3);
    }

    public fun deposit<T0>(arg0: &mut RewardVault, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::coin::value<T0>(&arg3);
        validate(arg0, arg1, arg2, 0x2::tx_context::sender(arg7), v0, v1, arg4, arg5, arg6);
        let v2 = CoinType<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinType<T0>>(&arg0.id, v2)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v2), arg3);
        } else {
            0x2::dynamic_field::add<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v2, arg3);
        };
        let v3 = TokenDepositedEvent{
            payment_id : arg1,
            project_id : arg2,
            token      : v0,
            amount     : v1,
            deadline   : arg4,
        };
        0x2::event::emit<TokenDepositedEvent>(v3);
    }

    public fun transfer_ownership(arg0: &mut RewardVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.owner = arg1;
    }

    public fun update_signer(arg0: &mut RewardVault, arg1: vector<u8>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        if (arg2) {
            assert!(0x2::vec_set::contains<vector<u8>>(&arg0.signers, &arg1), 4);
            0x2::vec_set::remove<vector<u8>>(&mut arg0.signers, &arg1);
        } else {
            0x2::vec_set::insert<vector<u8>>(&mut arg0.signers, arg1);
        };
    }

    fun validate(arg0: &mut RewardVault, arg1: u64, arg2: u64, arg3: address, arg4: 0x1::ascii::String, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert!(arg6 > 0x2::clock::timestamp_ms(arg8), 3);
        assert!(!0x2::vec_set::contains<u64>(&arg0.used_payment_ids, &arg1), 2);
        0x2::vec_set::insert<u64>(&mut arg0.used_payment_ids, arg1);
        let v0 = 0xd94252d8e5f5561ada000d29bb6437d2f45d94811099d3d230ce87ee56a89cab::signature_utils::recover_signer(arg3, arg1, arg2, arg4, arg5, arg6, arg7);
        assert!(0x2::vec_set::contains<vector<u8>>(&arg0.signers, &v0), 1);
    }

    public fun withdraw<T0>(arg0: &mut RewardVault, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        validate(arg0, arg1, arg2, arg3, v0, arg4, arg5, arg6, arg7);
        let v1 = CoinType<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinType<T0>>(&arg0.id, v1), 5);
        let v2 = 0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v1);
        assert!(0x2::coin::value<T0>(v2) >= arg4, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v2, arg4, arg8), arg3);
        let v3 = TokenWithdrawalEvent{
            payment_id : arg1,
            project_id : arg2,
            token      : v0,
            amount     : arg4,
            recipient  : arg3,
            deadline   : arg5,
        };
        0x2::event::emit<TokenWithdrawalEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

