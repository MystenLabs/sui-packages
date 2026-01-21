module 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::vault {
    struct AirdropVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        strategy: u8,
        target_asset: 0x1::option::Option<0x1::string::String>,
        ratio_bps: u64,
        fixed_reward: u64,
        milestones: vector<u64>,
        current_milestone_index: u64,
        max_reward_per_tx: u64,
        total_distributed: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: address,
        creator: address,
        strategy: u8,
        target_asset: 0x1::option::Option<0x1::string::String>,
        initial_balance: u64,
        timestamp_ms: u64,
    }

    struct AirdropClaimedEvent has copy, drop {
        recipient: address,
        vault_id: address,
        amount: u64,
        strategy: u8,
        timestamp_ms: u64,
    }

    struct AirdropFailedEvent has copy, drop {
        recipient: address,
        vault_id: address,
        requested_amount: u64,
        available_balance: u64,
        reason: vector<u8>,
        timestamp_ms: u64,
    }

    public fun close_vault<T0>(arg0: &mut AirdropVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v0, arg1), arg0.owner);
        };
    }

    public(friend) fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: 0x1::option::Option<0x1::string::String>, arg3: u64, arg4: u64, arg5: vector<u64>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg1 <= 1, 1);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = AirdropVault<T0>{
            id                      : 0x2::object::new(arg7),
            owner                   : v0,
            balance                 : 0x2::coin::into_balance<T0>(arg0),
            strategy                : arg1,
            target_asset            : arg2,
            ratio_bps               : arg3,
            fixed_reward            : arg4,
            milestones              : arg5,
            current_milestone_index : 0,
            max_reward_per_tx       : arg6,
            total_distributed       : 0,
        };
        let v2 = 0x2::object::uid_to_address(&v1.id);
        0x2::transfer::share_object<AirdropVault<T0>>(v1);
        let v3 = VaultCreatedEvent{
            vault_id        : v2,
            creator         : v0,
            strategy        : arg1,
            target_asset    : arg2,
            initial_balance : 0x2::coin::value<T0>(&arg0),
            timestamp_ms    : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        v2
    }

    public fun get_current_milestone_index<T0>(arg0: &AirdropVault<T0>) : u64 {
        arg0.current_milestone_index
    }

    public fun get_fixed_reward<T0>(arg0: &AirdropVault<T0>) : u64 {
        arg0.fixed_reward
    }

    public fun get_max_reward_per_tx<T0>(arg0: &AirdropVault<T0>) : u64 {
        arg0.max_reward_per_tx
    }

    public fun get_milestones<T0>(arg0: &AirdropVault<T0>) : vector<u64> {
        arg0.milestones
    }

    public fun get_ratio_bps<T0>(arg0: &AirdropVault<T0>) : u64 {
        arg0.ratio_bps
    }

    public fun get_strategy_milestone() : u8 {
        0
    }

    public fun get_strategy_ratio() : u8 {
        1
    }

    public fun get_target_asset<T0>(arg0: &AirdropVault<T0>) : 0x1::option::Option<0x1::string::String> {
        arg0.target_asset
    }

    public fun get_total_distributed<T0>(arg0: &AirdropVault<T0>) : u64 {
        arg0.total_distributed
    }

    public fun get_vault_balance<T0>(arg0: &AirdropVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_vault_owner<T0>(arg0: &AirdropVault<T0>) : address {
        arg0.owner
    }

    public fun get_vault_strategy<T0>(arg0: &AirdropVault<T0>) : u8 {
        arg0.strategy
    }

    public(friend) fun process_airdrop<T0>(arg0: &mut AirdropVault<T0>, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x1::option::is_some<0x1::string::String>(&arg0.target_asset)) {
            if (0x1::option::borrow<0x1::string::String>(&arg0.target_asset) != &arg3) {
                return
            };
        };
        let v1 = 0;
        if (arg0.strategy == 0) {
            if (arg0.current_milestone_index < 0x1::vector::length<u64>(&arg0.milestones)) {
                if (arg2 == *0x1::vector::borrow<u64>(&arg0.milestones, arg0.current_milestone_index)) {
                    v1 = arg0.fixed_reward;
                    arg0.current_milestone_index = arg0.current_milestone_index + 1;
                };
            };
        } else if (arg0.strategy == 1) {
            let v2 = (arg1 as u128) * (arg0.ratio_bps as u128) / 10000;
            let v3 = if (v2 > (arg0.max_reward_per_tx as u128)) {
                arg0.max_reward_per_tx
            } else {
                (v2 as u64)
            };
            v1 = v3;
        };
        if (v1 > 0) {
            let v4 = 0x2::balance::value<T0>(&arg0.balance);
            if (v4 >= v1) {
                arg0.total_distributed = arg0.total_distributed + v1;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg4), v0);
                let v5 = AirdropClaimedEvent{
                    recipient    : v0,
                    vault_id     : 0x2::object::uid_to_address(&arg0.id),
                    amount       : v1,
                    strategy     : arg0.strategy,
                    timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg4),
                };
                0x2::event::emit<AirdropClaimedEvent>(v5);
            } else {
                let v6 = AirdropFailedEvent{
                    recipient         : v0,
                    vault_id          : 0x2::object::uid_to_address(&arg0.id),
                    requested_amount  : v1,
                    available_balance : v4,
                    reason            : b"Insufficient vault balance",
                    timestamp_ms      : 0x2::tx_context::epoch_timestamp_ms(arg4),
                };
                0x2::event::emit<AirdropFailedEvent>(v6);
            };
        };
    }

    public fun top_up_vault<T0>(arg0: &mut AirdropVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    // decompiled from Move bytecode v6
}

