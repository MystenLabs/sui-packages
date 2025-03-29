module 0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::reward_vault {
    struct Modifier has copy, drop, store {
        kind: u8,
        value: u64,
    }

    struct RewardRegistry has store, key {
        id: 0x2::object::UID,
        owner: address,
        registered_count: u64,
    }

    struct ReceiverStatusKey has copy, drop, store {
        receiver: address,
    }

    struct ReceiverStatus has copy, drop, store {
        has_receiver: bool,
        registered_at: u64,
        subscription_count: u64,
    }

    struct Vault has store {
        accrued_rewards: u64,
        last_update_ts: u64,
        modifier: 0x1::option::Option<Modifier>,
    }

    struct RewardReceiver<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        vaults: 0x2::table::Table<0x2::object::ID, Vault>,
    }

    struct Debt has copy, drop, store {
        receiver: address,
        amount: u64,
    }

    struct RewardTransmitter<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        owner: address,
        reward_rate: u64,
        reward_balance: 0x2::balance::Balance<T0>,
        debt_queue: 0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::Queue<Debt>,
        num_receivers: u64,
        total_rewards_paid: u64,
    }

    struct RewardVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        transmitter_id: 0x2::object::ID,
        receivers: vector<address>,
        num_receivers: u64,
        base_reward_rate: u64,
        min_reward_period_sec: u64,
        reduction_per_additional_day: u64,
    }

    struct RewardVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        transmitter_id: 0x2::object::ID,
        owner: address,
        reward_rate: u64,
    }

    struct ReceiverSubscribed has copy, drop {
        receiver: address,
        vault_id: 0x2::object::ID,
        modifier_value: u64,
    }

    struct ReceiverUnsubscribed has copy, drop {
        receiver: address,
        vault_id: 0x2::object::ID,
    }

    struct RewardsClaimed has copy, drop {
        receiver: address,
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct ReceiverRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        receiver: address,
        initial_modifier: u64,
    }

    struct RewardsFunded has copy, drop {
        transmitter_id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct RewardsWithdrawn has copy, drop {
        transmitter_id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        owner: address,
    }

    struct ReceiverRegisteredInRegistry has copy, drop {
        receiver: address,
        registry_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ModifierKey has copy, drop, store {
        receiver: address,
        vault_id: 0x2::object::ID,
    }

    struct UpdateKey has copy, drop, store {
        receiver: address,
        vault_id: 0x2::object::ID,
    }

    struct RewardsKey has copy, drop, store {
        receiver: address,
        vault_id: 0x2::object::ID,
    }

    public fun add_to_sum_modifier(arg0: Modifier, arg1: u64, arg2: bool) : Modifier {
        assert!(arg0.kind == 0, 1);
        if (arg2) {
            Modifier{kind: 0, value: arg0.value + arg1}
        } else {
            let v1 = if (arg0.value > arg1) {
                arg0.value - arg1
            } else {
                0
            };
            Modifier{kind: 0, value: v1}
        }
    }

    public fun claim_rewards<T0: store + key>(arg0: &mut RewardVault<T0>, arg1: &mut RewardTransmitter<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        update_accrued_rewards<T0>(arg2, arg0, arg1, arg3, arg4);
        let v0 = RewardsKey{
            receiver : arg2,
            vault_id : 0x2::object::id<RewardVault<T0>>(arg0),
        };
        let v1 = if (0x2::dynamic_field::exists_with_type<RewardsKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<RewardsKey, u64>(&arg0.id, v0)
        } else {
            0
        };
        if (v1 > 0) {
            let v3 = 0x2::balance::value<T0>(&arg1.reward_balance);
            let v4 = if (v1 > v3) {
                let v5 = Debt{
                    receiver : arg2,
                    amount   : v1 - v3,
                };
                0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::push_back<Debt>(&mut arg1.debt_queue, v5);
                v3
            } else {
                v1
            };
            let v6 = if (v4 > 0) {
                0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.reward_balance, v4), arg4)
            } else {
                0x2::coin::zero<T0>(arg4)
            };
            let v7 = v6;
            if (0x2::dynamic_field::exists_with_type<RewardsKey, u64>(&arg0.id, v0)) {
                *0x2::dynamic_field::borrow_mut<RewardsKey, u64>(&mut arg0.id, v0) = 0;
            };
            process_debt_queue<T0>(arg1, arg4);
            let v8 = 0x2::coin::value<T0>(&v7);
            if (v8 > 0) {
                let v9 = RewardsClaimed{
                    receiver : arg2,
                    vault_id : 0x2::object::id<RewardVault<T0>>(arg0),
                    amount   : v8,
                };
                0x2::event::emit<RewardsClaimed>(v9);
            };
            v7
        } else {
            0x2::coin::zero<T0>(arg4)
        }
    }

    public entry fun create_and_share_registry(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RewardRegistry>(create_registry(arg0));
    }

    public fun create_mul_modifier(arg0: u64) : Modifier {
        Modifier{
            kind  : 1,
            value : arg0,
        }
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) : RewardRegistry {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = RewardRegistry{
            id               : 0x2::object::new(arg0),
            owner            : v0,
            registered_count : 0,
        };
        let v2 = RegistryCreated{
            registry_id : 0x2::object::id<RewardRegistry>(&v1),
            owner       : v0,
        };
        0x2::event::emit<RegistryCreated>(v2);
        v1
    }

    public fun create_sum_modifier(arg0: u64) : Modifier {
        Modifier{
            kind  : 0,
            value : arg0,
        }
    }

    public fun create_vault<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : (RewardVault<T0>, RewardTransmitter<T0>) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = RewardVault<T0>{
            id                           : 0x2::object::new(arg0),
            transmitter_id               : v2,
            receivers                    : 0x1::vector::empty<address>(),
            num_receivers                : 0,
            base_reward_rate             : 100,
            min_reward_period_sec        : 3600000,
            reduction_per_additional_day : 0,
        };
        let v4 = 0x2::object::id<RewardVault<T0>>(&v3);
        let v5 = RewardTransmitter<T0>{
            id                 : v1,
            vault_id           : v4,
            owner              : v0,
            reward_rate        : 100,
            reward_balance     : 0x2::balance::zero<T0>(),
            debt_queue         : 0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::new<Debt>(arg0),
            num_receivers      : 0,
            total_rewards_paid : 0,
        };
        let v6 = RewardVaultCreated{
            vault_id       : v4,
            transmitter_id : v2,
            owner          : v0,
            reward_rate    : 100,
        };
        0x2::event::emit<RewardVaultCreated>(v6);
        (v3, v5)
    }

    public fun decrease_modifier<T0: store + key>(arg0: &mut RewardVault<T0>, arg1: &mut RewardTransmitter<T0>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.transmitter_id == 0x2::object::id<RewardTransmitter<T0>>(arg1), 1);
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 3);
        assert!(0x1::vector::contains<address>(&arg0.receivers, &arg2), 1);
        update_accrued_rewards<T0>(arg2, arg0, arg1, arg4, arg5);
        let v0 = get_modifier<T0>(arg0, arg2);
        let v1 = if (v0 > arg3) {
            v0 - arg3
        } else {
            1
        };
        update_modifier<T0>(arg0, arg1, arg2, create_sum_modifier(v1), arg4, arg5);
    }

    public fun fund<T0: store + key>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut RewardTransmitter<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0, 3);
        0x2::balance::join<T0>(&mut arg1.reward_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg2, arg3)));
        let v1 = RewardsFunded{
            transmitter_id : 0x2::object::id<RewardTransmitter<T0>>(arg1),
            amount         : arg2,
            owner          : v0,
        };
        0x2::event::emit<RewardsFunded>(v1);
        pay_debts<T0>(arg1, arg3);
    }

    public entry fun fund_vault<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut RewardTransmitter<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0, 3);
        0x2::balance::join<T0>(&mut arg1.reward_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg2, arg3)));
        let v1 = RewardsFunded{
            transmitter_id : 0x2::object::id<RewardTransmitter<T0>>(arg1),
            amount         : arg2,
            owner          : v0,
        };
        0x2::event::emit<RewardsFunded>(v1);
        pay_debts<T0>(arg1, arg3);
    }

    public fun get_accrued_rewards<T0: store + key>(arg0: address, arg1: &mut RewardVault<T0>, arg2: &mut RewardTransmitter<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::vector::contains<address>(&arg1.receivers, &arg0), 1);
        assert!(arg1.transmitter_id == 0x2::object::id<RewardTransmitter<T0>>(arg2), 1);
        update_accrued_rewards<T0>(arg0, arg1, arg2, arg3, arg4);
        let v0 = RewardsKey{
            receiver : arg0,
            vault_id : 0x2::object::id<RewardVault<T0>>(arg1),
        };
        if (0x2::dynamic_field::exists_with_type<RewardsKey, u64>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow<RewardsKey, u64>(&arg1.id, v0)
        } else {
            0
        }
    }

    public fun get_base_reward_rate<T0: store + key>(arg0: &RewardVault<T0>) : u64 {
        arg0.base_reward_rate
    }

    public fun get_claimable_amount<T0: store + key>(arg0: &mut RewardVault<T0>, arg1: &RewardTransmitter<T0>, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        assert!(0x1::vector::contains<address>(&arg0.receivers, &arg2), 1);
        assert!(arg0.transmitter_id == 0x2::object::id<RewardTransmitter<T0>>(arg1), 1);
        let v0 = RewardsKey{
            receiver : arg2,
            vault_id : 0x2::object::id<RewardVault<T0>>(arg0),
        };
        if (0x2::dynamic_field::exists_with_type<RewardsKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<RewardsKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun get_claimable_amount_ro<T0: store + key>(arg0: &RewardVault<T0>, arg1: &RewardTransmitter<T0>, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        if (!0x1::vector::contains<address>(&arg0.receivers, &arg2)) {
            return 0
        };
        if (arg0.transmitter_id != 0x2::object::id<RewardTransmitter<T0>>(arg1)) {
            return 0
        };
        let v0 = RewardsKey{
            receiver : arg2,
            vault_id : 0x2::object::id<RewardVault<T0>>(arg0),
        };
        if (0x2::dynamic_field::exists_with_type<RewardsKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<RewardsKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun get_debt_queue_info<T0: store + key>(arg0: &RewardTransmitter<T0>) : (u64, u64) {
        let v0 = 0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::length<Debt>(&arg0.debt_queue);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + 0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::borrow<Debt>(&arg0.debt_queue, v2).amount;
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_last_update_time<T0: store + key>(arg0: &RewardVault<T0>, arg1: address) : u64 {
        let v0 = UpdateKey{
            receiver : arg1,
            vault_id : 0x2::object::id<RewardVault<T0>>(arg0),
        };
        if (0x2::dynamic_field::exists_with_type<UpdateKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<UpdateKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun get_modifier<T0: store + key>(arg0: &RewardVault<T0>, arg1: address) : u64 {
        assert!(0x1::vector::contains<address>(&arg0.receivers, &arg1), 1);
        let v0 = ModifierKey{
            receiver : arg1,
            vault_id : 0x2::object::id<RewardVault<T0>>(arg0),
        };
        if (0x2::dynamic_field::exists_with_type<ModifierKey, Modifier>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<ModifierKey, Modifier>(&arg0.id, v0).value
        } else {
            1
        }
    }

    public fun get_reward_balance<T0: store + key>(arg0: &RewardTransmitter<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_balance)
    }

    public fun get_reward_periods<T0: store + key>(arg0: &RewardVault<T0>) : (u64, u64) {
        (arg0.min_reward_period_sec, arg0.reduction_per_additional_day)
    }

    public fun get_reward_vault_id<T0>(arg0: &RewardVault<T0>) : 0x2::object::ID {
        0x2::object::id<RewardVault<T0>>(arg0)
    }

    public fun get_total_rewards_paid<T0: store + key>(arg0: &RewardTransmitter<T0>) : u64 {
        arg0.total_rewards_paid
    }

    public fun get_transmitter_id<T0>(arg0: &RewardVault<T0>) : 0x2::object::ID {
        arg0.transmitter_id
    }

    public fun get_vault_id<T0>(arg0: &RewardTransmitter<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun increase_modifier<T0: store + key>(arg0: &mut RewardVault<T0>, arg1: &mut RewardTransmitter<T0>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.transmitter_id == 0x2::object::id<RewardTransmitter<T0>>(arg1), 1);
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 3);
        assert!(0x1::vector::contains<address>(&arg0.receivers, &arg2), 1);
        update_accrued_rewards<T0>(arg2, arg0, arg1, arg4, arg5);
        let v0 = create_sum_modifier(get_modifier<T0>(arg0, arg2) + arg3);
        update_modifier<T0>(arg0, arg1, arg2, v0, arg4, arg5);
    }

    fun internal_subscribe<T0>(arg0: &mut RewardVault<T0>, arg1: &mut RewardTransmitter<T0>, arg2: 0x1::option::Option<Modifier>, arg3: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg0.transmitter_id == 0x2::object::id<RewardTransmitter<T0>>(arg1), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg0.receivers, &v0), 5);
        let v1 = RewardReceiver<T0>{
            id     : 0x2::object::new(arg3),
            owner  : v0,
            vaults : 0x2::table::new<0x2::object::ID, Vault>(arg3),
        };
        let v2 = Vault{
            accrued_rewards : 0,
            last_update_ts  : 0x2::tx_context::epoch_timestamp_ms(arg3),
            modifier        : arg2,
        };
        0x2::table::add<0x2::object::ID, Vault>(&mut v1.vaults, 0x2::object::id<RewardVault<T0>>(arg0), v2);
        0x2::transfer::transfer<RewardReceiver<T0>>(v1, v0);
        let v3 = if (0x1::option::is_some<Modifier>(&arg2)) {
            let v4 = *0x1::option::borrow<Modifier>(&arg2);
            v4.value
        } else {
            0
        };
        let v5 = ReceiverRegistered{
            vault_id         : 0x2::object::id<RewardVault<T0>>(arg0),
            receiver         : v0,
            initial_modifier : v3,
        };
        0x2::event::emit<ReceiverRegistered>(v5);
        0x1::vector::push_back<address>(&mut arg0.receivers, v0);
        arg0.num_receivers = arg0.num_receivers + 1;
        arg1.num_receivers = arg1.num_receivers + 1;
        let v6 = if (0x1::option::is_some<Modifier>(&arg2)) {
            let v7 = 0x1::option::extract<Modifier>(&mut arg2);
            v7.value
        } else {
            0
        };
        let v8 = ReceiverSubscribed{
            receiver       : v0,
            vault_id       : 0x2::object::id<RewardVault<T0>>(arg0),
            modifier_value : v6,
        };
        0x2::event::emit<ReceiverSubscribed>(v8);
        v0
    }

    public fun is_subscribed<T0>(arg0: address, arg1: &RewardVault<T0>) : bool {
        0x1::vector::contains<address>(&arg1.receivers, &arg0)
    }

    fun ms_to_sec(arg0: u64) : u64 {
        arg0 / 1000
    }

    fun pay_debts<T0>(arg0: &mut RewardTransmitter<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&mut arg0.reward_balance);
        while (!0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::is_empty<Debt>(&arg0.debt_queue) && v0 > 0) {
            let v1 = 0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::front<Debt>(&arg0.debt_queue);
            let v2 = v1.amount;
            if (v2 > v0) {
                let v3 = Debt{
                    receiver : v1.receiver,
                    amount   : v2 - v0,
                };
                0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::dequeue<Debt>(&mut arg0.debt_queue);
                0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::push_back<Debt>(&mut arg0.debt_queue, v3);
                break
            };
            0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::dequeue<Debt>(&mut arg0.debt_queue);
            v0 = v0 - v2;
        };
    }

    fun process_debt_queue<T0>(arg0: &mut RewardTransmitter<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.reward_balance;
        let v1 = 0x2::balance::value<T0>(v0);
        if (0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::is_empty<Debt>(&arg0.debt_queue) || v1 == 0) {
            return
        };
        while (!0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::is_empty<Debt>(&arg0.debt_queue) && v1 > 0) {
            let v2 = 0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::front<Debt>(&arg0.debt_queue);
            let v3 = v2.amount;
            let v4 = v2.receiver;
            if (v3 > v1) {
                0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::dequeue<Debt>(&mut arg0.debt_queue);
                let v5 = Debt{
                    receiver : v4,
                    amount   : v3 - v1,
                };
                0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::push_back<Debt>(&mut arg0.debt_queue, v5);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, v1), arg1), v4);
                break
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, v3), arg1), v4);
            v1 = v1 - v3;
            0xa41a943ee0dbd3470b88127f0d7db020aa6ef895f0fe67688967f0b11329f380::queue::dequeue<Debt>(&mut arg0.debt_queue);
        };
    }

    public fun register_in_registry(arg0: &mut RewardRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ReceiverStatusKey{receiver: arg1};
        if (!0x2::dynamic_field::exists_with_type<ReceiverStatusKey, ReceiverStatus>(&arg0.id, v0)) {
            let v1 = ReceiverStatus{
                has_receiver       : true,
                registered_at      : 0x2::tx_context::epoch_timestamp_ms(arg2),
                subscription_count : 0,
            };
            0x2::dynamic_field::add<ReceiverStatusKey, ReceiverStatus>(&mut arg0.id, v0, v1);
            arg0.registered_count = arg0.registered_count + 1;
            let v2 = ReceiverRegisteredInRegistry{
                receiver    : arg1,
                registry_id : 0x2::object::id<RewardRegistry>(arg0),
                timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg2),
            };
            0x2::event::emit<ReceiverRegisteredInRegistry>(v2);
        };
    }

    public fun register_receiver<T0>(arg0: address, arg1: &mut RewardVault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg1.receivers, &arg0), 7);
        let v0 = RewardReceiver<T0>{
            id     : 0x2::object::new(arg3),
            owner  : arg0,
            vaults : 0x2::table::new<0x2::object::ID, Vault>(arg3),
        };
        let v1 = Vault{
            accrued_rewards : 0,
            last_update_ts  : 0x2::tx_context::epoch_timestamp_ms(arg3),
            modifier        : 0x1::option::some<Modifier>(create_sum_modifier(arg2)),
        };
        0x2::table::add<0x2::object::ID, Vault>(&mut v0.vaults, 0x2::object::id<RewardVault<T0>>(arg1), v1);
        0x1::vector::push_back<address>(&mut arg1.receivers, arg0);
        arg1.num_receivers = arg1.num_receivers + 1;
        0x2::transfer::transfer<RewardReceiver<T0>>(v0, arg0);
        let v2 = ReceiverRegistered{
            vault_id         : 0x2::object::id<RewardVault<T0>>(arg1),
            receiver         : arg0,
            initial_modifier : arg2,
        };
        0x2::event::emit<ReceiverRegistered>(v2);
    }

    public fun register_receiver_with_registry<T0>(arg0: address, arg1: &mut RewardVault<T0>, arg2: u64, arg3: &mut RewardRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        register_receiver<T0>(arg0, arg1, arg2, arg4);
        register_in_registry(arg3, arg0, arg4);
    }

    fun safe_multiply(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun safe_time_diff_ms(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    fun sec_to_ms(arg0: u64) : u64 {
        arg0 * 1000
    }

    public entry fun subscribe<T0>(arg0: &mut RewardVault<T0>, arg1: &mut RewardTransmitter<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        internal_subscribe<T0>(arg0, arg1, 0x1::option::some<Modifier>(create_sum_modifier(0)), arg3);
    }

    public fun subscribe_with_modifier<T0>(arg0: &mut RewardVault<T0>, arg1: &mut RewardTransmitter<T0>, arg2: Modifier, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        internal_subscribe<T0>(arg0, arg1, 0x1::option::some<Modifier>(arg2), arg4);
    }

    public entry fun unsubscribe<T0>(arg0: &mut RewardVault<T0>, arg1: &mut RewardTransmitter<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.transmitter_id == 0x2::object::id<RewardTransmitter<T0>>(arg1), 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.receivers, &v0);
        assert!(v1, 1);
        0x1::vector::remove<address>(&mut arg0.receivers, v2);
        if (arg0.num_receivers > 0) {
            arg0.num_receivers = arg0.num_receivers - 1;
        };
        if (arg1.num_receivers > 0) {
            arg1.num_receivers = arg1.num_receivers - 1;
        };
        let v3 = ReceiverUnsubscribed{
            receiver : v0,
            vault_id : 0x2::object::id<RewardVault<T0>>(arg0),
        };
        0x2::event::emit<ReceiverUnsubscribed>(v3);
    }

    public fun update_accrued_rewards<T0: store + key>(arg0: address, arg1: &mut RewardVault<T0>, arg2: &mut RewardTransmitter<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::contains<address>(&arg1.receivers, &arg0), 1);
        assert!(arg1.transmitter_id == 0x2::object::id<RewardTransmitter<T0>>(arg2), 1);
        let v0 = UpdateKey{
            receiver : arg0,
            vault_id : 0x2::object::id<RewardVault<T0>>(arg1),
        };
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        if (0x2::dynamic_field::exists_with_type<UpdateKey, u64>(&arg1.id, v0)) {
            let v2 = ms_to_sec(safe_time_diff_ms(v1, *0x2::dynamic_field::borrow<UpdateKey, u64>(&arg1.id, v0)));
            if (v2 > 0) {
                let v3 = ms_to_sec(3600000);
                let v4 = ms_to_sec(604800000);
                let v5 = if (v2 > v4) {
                    v4
                } else {
                    v2
                };
                let v6 = arg2.reward_rate;
                let v7 = if (v5 > v3) {
                    let v8 = safe_multiply(v6, 100) / 100;
                    if (v8 < v6 / 2) {
                        v6 / 2
                    } else {
                        v8
                    }
                } else {
                    v6
                };
                let v9 = safe_multiply(safe_multiply(v7, get_modifier<T0>(arg1, arg0)), v5);
                let v10 = v9;
                let v11 = 0x2::balance::value<T0>(&arg2.reward_balance);
                let v12 = arg2.num_receivers;
                let v13 = if (v11 > 0 && v12 > 0) {
                    let v14 = v11 / v12;
                    let v15 = if (v11 >= 1000000000) {
                        1000000
                    } else {
                        10000
                    };
                    if (v12 == 1) {
                        if (v11 / 100000 > 1) {
                            1
                        } else {
                            1
                        }
                    } else if (v14 > v15) {
                        v14 / v15
                    } else {
                        1
                    }
                } else {
                    1
                };
                let v16 = v13;
                let v17 = if (v11 > 10000) {
                    v11 / 10000
                } else {
                    1
                };
                if (v13 > v17) {
                    v16 = v17;
                };
                let v18 = v9 >= v16 || v9 == 0;
                let v19 = RewardsKey{
                    receiver : arg0,
                    vault_id : 0x2::object::id<RewardVault<T0>>(arg1),
                };
                let v20 = if (v11 > 0) {
                    if (arg2.num_receivers > 0) {
                        if (v18) {
                            v9 > 0
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v20) {
                    let v21 = v11 / arg2.num_receivers;
                    if (v9 > v21) {
                        v10 = v21;
                    };
                    if (0x2::dynamic_field::exists_with_type<RewardsKey, u64>(&arg1.id, v19)) {
                        let v22 = 0x2::dynamic_field::borrow_mut<RewardsKey, u64>(&mut arg1.id, v19);
                        *v22 = *v22 + v10;
                    } else {
                        0x2::dynamic_field::add<RewardsKey, u64>(&mut arg1.id, v19, v10);
                    };
                };
                *0x2::dynamic_field::borrow_mut<UpdateKey, u64>(&mut arg1.id, v0) = v1;
            };
        } else {
            0x2::dynamic_field::add<UpdateKey, u64>(&mut arg1.id, v0, v1);
            let v23 = RewardsKey{
                receiver : arg0,
                vault_id : 0x2::object::id<RewardVault<T0>>(arg1),
            };
            if (!0x2::dynamic_field::exists_with_type<RewardsKey, u64>(&arg1.id, v23)) {
                0x2::dynamic_field::add<RewardsKey, u64>(&mut arg1.id, v23, 0);
            };
        };
    }

    public fun update_modifier<T0: store + key>(arg0: &mut RewardVault<T0>, arg1: &mut RewardTransmitter<T0>, arg2: address, arg3: Modifier, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.transmitter_id == 0x2::object::id<RewardTransmitter<T0>>(arg1), 1);
        assert!(0x1::vector::contains<address>(&arg0.receivers, &arg2), 1);
        update_accrued_rewards<T0>(arg2, arg0, arg1, arg4, arg5);
        let v0 = ModifierKey{
            receiver : arg2,
            vault_id : 0x2::object::id<RewardVault<T0>>(arg0),
        };
        if (0x2::dynamic_field::exists_with_type<ModifierKey, Modifier>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<ModifierKey, Modifier>(&mut arg0.id, v0) = arg3;
        } else {
            0x2::dynamic_field::add<ModifierKey, Modifier>(&mut arg0.id, v0, arg3);
        };
        let v1 = ReceiverSubscribed{
            receiver       : arg2,
            vault_id       : 0x2::object::id<RewardVault<T0>>(arg0),
            modifier_value : arg3.value,
        };
        0x2::event::emit<ReceiverSubscribed>(v1);
    }

    public fun update_subscription_count(arg0: &mut RewardRegistry, arg1: address, arg2: bool) {
        let v0 = ReceiverStatusKey{receiver: arg1};
        if (0x2::dynamic_field::exists_with_type<ReceiverStatusKey, ReceiverStatus>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<ReceiverStatusKey, ReceiverStatus>(&mut arg0.id, v0);
            if (arg2) {
                v1.subscription_count = v1.subscription_count + 1;
            } else if (v1.subscription_count > 0) {
                v1.subscription_count = v1.subscription_count - 1;
            };
        };
    }

    public fun withdraw<T0: store + key>(arg0: &mut RewardTransmitter<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 3);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= arg1, 2);
        let v1 = RewardsWithdrawn{
            transmitter_id : 0x2::object::id<RewardTransmitter<T0>>(arg0),
            amount         : arg1,
            owner          : v0,
        };
        0x2::event::emit<RewardsWithdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

