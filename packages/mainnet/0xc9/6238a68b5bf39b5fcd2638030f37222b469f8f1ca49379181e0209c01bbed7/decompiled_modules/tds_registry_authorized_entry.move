module 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_registry_authorized_entry {
    struct UpgradeRegistryEvent has copy, drop {
        signer: address,
        prev_version: u64,
        version: u64,
    }

    struct AddAuthorizedUserEvent has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct RemoveAuthorizedUserEvent has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct SuspendTransactionEvent has copy, drop {
        signer: address,
    }

    struct ResumeTransactionEvent has copy, drop {
        signer: address,
    }

    struct IncentiviseEvent has copy, drop {
        signer: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SetAvailableIncentiveAmountEvent has copy, drop {
        signer: address,
        index: u64,
        prev_amount: u64,
        amount: u64,
    }

    struct NewPortfolioVaultEvent has copy, drop {
        signer: address,
        index: u64,
        info: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Info,
        config: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Config,
    }

    public(friend) entry fun add_authorized_user(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, v2, _, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::add_authorized_user(v2, 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v12 = AddAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(v2),
        };
        0x2::event::emit<AddAuthorizedUserEvent>(v12);
    }

    public(friend) entry fun incentivise<T0>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let v0 = IncentiviseEvent{
            signer : 0x2::tx_context::sender(arg2),
            token  : 0x1::type_name::get<T0>(),
            amount : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::incentivise_<T0>(arg0, arg1),
        };
        0x2::event::emit<IncentiviseEvent>(v0);
    }

    public(friend) entry fun new_portfolio_vault<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: bool, arg26: vector<u64>, arg27: vector<u64>, arg28: vector<bool>, arg29: u64, arg30: u64, arg31: u64, arg32: u64, arg33: vector<address>, arg34: &0x2::clock::Clock, arg35: &mut 0x2::tx_context::TxContext) {
        safety_check(arg0, arg35);
        let (v0, v1, v2) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::new_portfolio_vault_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::create_payoff_configs(arg26, arg27, arg28), arg29, arg30, arg31, arg32, arg33, arg34, arg35);
        let v3 = NewPortfolioVaultEvent{
            signer : 0x2::tx_context::sender(arg35),
            index  : v0,
            info   : v1,
            config : v2,
        };
        0x2::event::emit<NewPortfolioVaultEvent>(v3);
    }

    public(friend) entry fun remove_authorized_user(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg2);
        let (_, _, v2, _, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::remove_authorized_user(v2, 0x1::vector::pop_back<address>(&mut arg1));
        };
        let v12 = RemoveAuthorizedUserEvent{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::whitelist(v2),
        };
        0x2::event::emit<RemoveAuthorizedUserEvent>(v12);
    }

    public(friend) entry fun resume_transaction(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg1);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::resume_transaction_(arg0);
        let v0 = ResumeTransactionEvent{signer: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<ResumeTransactionEvent>(v0);
    }

    fun safety_check(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_registry_authority(arg0, arg1);
    }

    public(friend) entry fun set_available_incentive_amount(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg3);
        let v0 = SetAvailableIncentiveAmountEvent{
            signer      : 0x2::tx_context::sender(arg3),
            index       : arg1,
            prev_amount : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::set_available_incentive_amount_(arg0, arg1, arg2),
            amount      : arg2,
        };
        0x2::event::emit<SetAvailableIncentiveAmountEvent>(v0);
    }

    public(friend) entry fun suspend_transaction(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) {
        safety_check(arg0, arg1);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::suspend_transaction_(arg0);
        let v0 = SuspendTransactionEvent{signer: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<SuspendTransactionEvent>(v0);
    }

    public(friend) entry fun upgrade_registry(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_registry_upgradability(arg0, arg1);
        let (_, _, _, _, _, _, _, _, _, _, v10, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        *v10 = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_version();
        let v12 = UpgradeRegistryEvent{
            signer       : 0x2::tx_context::sender(arg1),
            prev_version : *v10,
            version      : *v10,
        };
        0x2::event::emit<UpgradeRegistryEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

