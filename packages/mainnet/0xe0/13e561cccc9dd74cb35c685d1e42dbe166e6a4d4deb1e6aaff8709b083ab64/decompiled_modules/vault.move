module 0x2425ab01461275be3f39a1ee22c9d039559f6989cad8579abff91520ebdc0021::vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        pool_id: 0x2::object::ID,
        position_id: 0x1::option::Option<0x2::object::ID>,
        lower_tick: u32,
        upper_tick: u32,
        last_compound_ts: u64,
        last_claim_ts: u64,
        rebalance_count: u64,
        pending_fees_a: 0x2::balance::Balance<T0>,
        pending_fees_b: 0x2::balance::Balance<T1>,
    }

    struct BotCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        pool_id: 0x2::object::ID,
    }

    struct PositionOpened has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lower_tick: u32,
        upper_tick: u32,
    }

    struct PositionClosed has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct Rebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        new_lower_tick: u32,
        new_upper_tick: u32,
        timestamp: u64,
    }

    struct FeesDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct Compounded has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        timestamp: u64,
    }

    struct RewardsClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ZapIn has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        amount_a: u64,
        amount_b: u64,
    }

    public entry fun create_vault<T0, T1>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0, T1>{
            id               : 0x2::object::new(arg1),
            owner            : 0x2::tx_context::sender(arg1),
            pool_id          : arg0,
            position_id      : 0x1::option::none<0x2::object::ID>(),
            lower_tick       : 0,
            upper_tick       : 0,
            last_compound_ts : 0,
            last_claim_ts    : 0,
            rebalance_count  : 0,
            pending_fees_a   : 0x2::balance::zero<T0>(),
            pending_fees_b   : 0x2::balance::zero<T1>(),
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        let v2 = BotCap{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        0x2::transfer::transfer<BotCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
        let v3 = VaultCreated{
            vault_id : v1,
            owner    : 0x2::tx_context::sender(arg1),
            pool_id  : arg0,
        };
        0x2::event::emit<VaultCreated>(v3);
    }

    public fun get_pending_fees<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.pending_fees_a), 0x2::balance::value<T1>(&arg0.pending_fees_b))
    }

    public fun get_vault_info<T0, T1>(arg0: &Vault<T0, T1>) : (address, 0x2::object::ID, 0x1::option::Option<0x2::object::ID>, u32, u32, u64, u64, u64) {
        (arg0.owner, arg0.pool_id, arg0.position_id, arg0.lower_tick, arg0.upper_tick, arg0.last_compound_ts, arg0.last_claim_ts, arg0.rebalance_count)
    }

    public fun is_out_of_range<T0, T1>(arg0: &Vault<T0, T1>, arg1: u128) : bool {
        false
    }

    public entry fun record_claim_rewards<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &BotCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_claim_ts + 172800000, 5);
        arg0.last_claim_ts = v0;
        let v1 = RewardsClaimed{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            timestamp : v0,
        };
        0x2::event::emit<RewardsClaimed>(v1);
    }

    public entry fun record_fees_collected<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &BotCap, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        0x2::balance::join<T0>(&mut arg0.pending_fees_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.pending_fees_b, 0x2::coin::into_balance<T1>(arg2));
        let v0 = FeesDeposited{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            amount_a : 0x2::coin::value<T0>(&arg1),
            amount_b : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<FeesDeposited>(v0);
    }

    public entry fun record_position_opened<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID, arg2: u32, arg3: u32, arg4: &BotCap, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.position_id), 3);
        arg0.position_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.lower_tick = arg2;
        arg0.upper_tick = arg3;
        let v0 = PositionOpened{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            position_id : arg1,
            lower_tick  : arg2,
            upper_tick  : arg3,
        };
        0x2::event::emit<PositionOpened>(v0);
    }

    public entry fun record_rebalance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: &BotCap, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.position_id, &arg1), 2);
        arg0.position_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg0.lower_tick = arg3;
        arg0.upper_tick = arg4;
        arg0.rebalance_count = arg0.rebalance_count + 1;
        let v0 = PositionClosed{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            position_id : arg1,
        };
        0x2::event::emit<PositionClosed>(v0);
        let v1 = PositionOpened{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            position_id : arg2,
            lower_tick  : arg3,
            upper_tick  : arg4,
        };
        0x2::event::emit<PositionOpened>(v1);
        let v2 = Rebalanced{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            old_position_id : arg1,
            new_position_id : arg2,
            new_lower_tick  : arg3,
            new_upper_tick  : arg4,
            timestamp       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<Rebalanced>(v2);
    }

    public entry fun transfer_bot_cap(arg0: BotCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<BotCap>(arg0, arg1);
    }

    public entry fun transfer_ownership<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
    }

    public entry fun withdraw_pending_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &BotCap, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_compound_ts + 432000000, 4);
        arg0.last_compound_ts = v0;
        let v1 = Compounded{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            amount_a  : 0x2::balance::value<T0>(&arg0.pending_fees_a),
            amount_b  : 0x2::balance::value<T1>(&arg0.pending_fees_b),
            timestamp : v0,
        };
        0x2::event::emit<Compounded>(v1);
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_fees_a), arg3), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.pending_fees_b), arg3))
    }

    public entry fun withdraw_pending_fees_for_position<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &BotCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::balance::value<T0>(&arg0.pending_fees_a);
        0x2::balance::value<T1>(&arg0.pending_fees_b);
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_fees_a), arg2), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.pending_fees_b), arg2))
    }

    public entry fun zap_in<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.pending_fees_b, 0x2::coin::into_balance<T1>(arg1));
        let v0 = ZapIn{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            sender   : 0x2::tx_context::sender(arg2),
            amount_a : 0,
            amount_b : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<ZapIn>(v0);
    }

    // decompiled from Move bytecode v7
}

