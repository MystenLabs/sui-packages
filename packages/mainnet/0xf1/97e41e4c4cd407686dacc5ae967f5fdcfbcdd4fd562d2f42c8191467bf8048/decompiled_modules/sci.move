module 0xf197e41e4c4cd407686dacc5ae967f5fdcfbcdd4fd562d2f42c8191467bf8048::sci {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct SettlementCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        epoch: u64,
    }

    struct AgentVault has key {
        id: 0x2::object::UID,
        treasury_address: address,
        settlement_epoch: u64,
        is_paused: bool,
    }

    struct AgentBalanceKey<phantom T0> has copy, drop, store {
        pos0: address,
        pos1: 0x1::string::String,
    }

    struct SettlementReceiptKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct AgentFunded has copy, drop {
        owner: address,
        agent_id: 0x1::string::String,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct AgentSettled has copy, drop {
        owner: address,
        agent_id: 0x1::string::String,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        fiat_ref: 0x1::string::String,
    }

    struct AgentWithdrawn has copy, drop {
        owner: address,
        agent_id: 0x1::string::String,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct VaultPaused has copy, drop {
        by: address,
    }

    struct VaultUnpaused has copy, drop {
        by: address,
    }

    struct TreasuryUpdated has copy, drop {
        old_treasury: address,
        new_treasury: address,
    }

    struct SettlementCapCreated has copy, drop {
        recipient: address,
        vault_id: 0x2::object::ID,
        epoch: u64,
    }

    struct SettlementEpochBumped has copy, drop {
        new_epoch: u64,
    }

    public fun balance<T0>(arg0: &AgentVault, arg1: address, arg2: 0x1::string::String) : u64 {
        let v0 = AgentBalanceKey<T0>{
            pos0 : arg1,
            pos1 : arg2,
        };
        if (0x2::dynamic_field::exists<AgentBalanceKey<T0>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<AgentBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun bump_settlement_epoch(arg0: &mut AgentVault, arg1: &AdminCap) {
        assert!(arg1.vault_id == 0x2::object::id<AgentVault>(arg0), 13906835883740758023);
        arg0.settlement_epoch = arg0.settlement_epoch + 1;
        let v0 = SettlementEpochBumped{new_epoch: arg0.settlement_epoch};
        0x2::event::emit<SettlementEpochBumped>(v0);
    }

    public fun create_settlement_cap(arg0: &AgentVault, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<AgentVault>(arg0), 13906835789251477511);
        assert!(arg2 != @0x0, 13906835793546838029);
        let v0 = SettlementCap{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::id<AgentVault>(arg0),
            epoch    : arg0.settlement_epoch,
        };
        let v1 = SettlementCapCreated{
            recipient : arg2,
            vault_id  : 0x2::object::id<AgentVault>(arg0),
            epoch     : arg0.settlement_epoch,
        };
        0x2::event::emit<SettlementCapCreated>(v1);
        0x2::transfer::transfer<SettlementCap>(v0, arg2);
    }

    public fun fund_agent<T0>(arg0: &mut AgentVault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 13906834822883704837);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 13906834831473377281);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = AgentBalanceKey<T0>{
            pos0 : v1,
            pos1 : arg1,
        };
        if (!0x2::dynamic_field::exists<AgentBalanceKey<T0>>(&arg0.id, v2)) {
            0x2::dynamic_field::add<AgentBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<AgentBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg2));
        };
        let v3 = AgentFunded{
            owner      : v1,
            agent_id   : arg1,
            token_type : 0x1::type_name::with_defining_ids<T0>(),
            amount     : v0,
        };
        0x2::event::emit<AgentFunded>(v3);
    }

    entry fun fund_agent_entry<T0>(arg0: &mut AgentVault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        fund_agent<T0>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AdminCap{
            id       : 0x2::object::new(arg0),
            vault_id : v1,
        };
        let v3 = SettlementCap{
            id       : 0x2::object::new(arg0),
            vault_id : v1,
            epoch    : 0,
        };
        let v4 = AgentVault{
            id               : v0,
            treasury_address : 0x2::tx_context::sender(arg0),
            settlement_epoch : 0,
            is_paused        : false,
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<SettlementCap>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AgentVault>(v4);
    }

    public fun is_paused(arg0: &AgentVault) : bool {
        arg0.is_paused
    }

    public fun is_settlement_cap_valid(arg0: &AgentVault, arg1: &SettlementCap) : bool {
        arg1.vault_id == 0x2::object::id<AgentVault>(arg0) && arg1.epoch == arg0.settlement_epoch
    }

    public fun is_settlement_processed(arg0: &AgentVault, arg1: 0x1::string::String) : bool {
        let v0 = SettlementReceiptKey{pos0: arg1};
        0x2::dynamic_field::exists<SettlementReceiptKey>(&arg0.id, v0)
    }

    public fun pause(arg0: &mut AgentVault, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<AgentVault>(arg0), 13906835638927622151);
        arg0.is_paused = true;
        let v0 = VaultPaused{by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<VaultPaused>(v0);
    }

    public fun settle_payout<T0>(arg0: &mut AgentVault, arg1: &SettlementCap, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 13906835127826382853);
        assert!(arg1.vault_id == 0x2::object::id<AgentVault>(arg0), 13906835132121481223);
        assert!(arg1.epoch == arg0.settlement_epoch, 13906835136416579593);
        assert!(arg4 > 0, 13906835140711022593);
        let v0 = SettlementReceiptKey{pos0: arg5};
        assert!(!0x2::dynamic_field::exists<SettlementReceiptKey>(&arg0.id, v0), 13906835157891547147);
        0x2::dynamic_field::add<SettlementReceiptKey, bool>(&mut arg0.id, v0, true);
        let v1 = AgentBalanceKey<T0>{
            pos0 : arg2,
            pos1 : arg3,
        };
        assert!(0x2::dynamic_field::exists<AgentBalanceKey<T0>>(&arg0.id, v1), 13906835175070892035);
        let v2 = 0x2::dynamic_field::borrow_mut<AgentBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg4, 13906835187955793923);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg4), arg6), arg0.treasury_address);
        if (0x2::balance::value<T0>(v2) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<AgentBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1));
        };
        let v3 = AgentSettled{
            owner      : arg2,
            agent_id   : arg3,
            token_type : 0x1::type_name::with_defining_ids<T0>(),
            amount     : arg4,
            fiat_ref   : arg5,
        };
        0x2::event::emit<AgentSettled>(v3);
    }

    entry fun settle_payout_entry<T0>(arg0: &mut AgentVault, arg1: &SettlementCap, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        settle_payout<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun settlement_epoch(arg0: &AgentVault) : u64 {
        arg0.settlement_epoch
    }

    public fun treasury_address(arg0: &AgentVault) : address {
        arg0.treasury_address
    }

    public fun unpause(arg0: &mut AgentVault, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<AgentVault>(arg0), 13906835668992393223);
        arg0.is_paused = false;
        let v0 = VaultUnpaused{by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<VaultUnpaused>(v0);
    }

    public fun update_treasury(arg0: &mut AgentVault, arg1: &AdminCap, arg2: address) {
        assert!(arg1.vault_id == 0x2::object::id<AgentVault>(arg0), 13906835716237033479);
        assert!(arg2 != @0x0, 13906835720532393997);
        arg0.treasury_address = arg2;
        let v0 = TreasuryUpdated{
            old_treasury : arg0.treasury_address,
            new_treasury : arg2,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun withdraw<T0>(arg0: &mut AgentVault, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 13906834960322396161);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = AgentBalanceKey<T0>{
            pos0 : v0,
            pos1 : arg1,
        };
        assert!(0x2::dynamic_field::exists<AgentBalanceKey<T0>>(&arg0.id, v1), 13906834977502396419);
        let v2 = 0x2::dynamic_field::borrow_mut<AgentBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg2, 13906834990387298307);
        if (0x2::balance::value<T0>(v2) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<AgentBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1));
        };
        let v3 = AgentWithdrawn{
            owner      : v0,
            agent_id   : arg1,
            token_type : 0x1::type_name::with_defining_ids<T0>(),
            amount     : arg2,
        };
        0x2::event::emit<AgentWithdrawn>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg2), arg3)
    }

    entry fun withdraw_entry<T0>(arg0: &mut AgentVault, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

