module 0x99d2fde86269d57dd49ae091cc5c3033e62a4405c2d802b02d8d60e81d933559::stake_cb {
    struct BondMintedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        value: u64,
        tier: u64,
        shares: u64,
        unlock_time: u64,
        owner: address,
    }

    struct BondConvertEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        old_tier: u64,
        new_tier: u64,
        remaining_stake_assets: u64,
        remaining_shares: u64,
        converted_stake_assets: u64,
        converted_shares: u64,
        unmature_conversion: bool,
        conversion_fee: u64,
        conversion_timestamp_ms: u64,
        unlock_time: u64,
        owner: address,
    }

    struct BondBurnedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        tier: u64,
        value: u64,
        shares: u64,
        burn_timestamp_ms: u64,
        fee: u64,
    }

    struct BondWithdrawalEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        old_tier: u64,
        new_tier: u64,
        withdrawn_stake_assets: u64,
        remaining_stake_assets: u64,
        old_shares: u64,
        new_shares: u64,
        unmature_withdrawal: bool,
        withdrawal_fee: u64,
        withdrawal_timestamp_ms: u64,
        unlock_time: u64,
        owner: address,
    }

    struct EpochSnapshot has copy, drop, store {
        epoch: u64,
        amount: u64,
        multiplier: u64,
        time_weight: u64,
    }

    struct ConvertibleBond has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        tier: u64,
        duration: u64,
        unlock_time: u64,
        value: u64,
        shares: u64,
        compensation: bool,
        image_url: 0x2::url::Url,
        start_epoch: u64,
        base_multiplier: u64,
        last_claimed_epoch: u64,
        epoch_snapshots: vector<EpochSnapshot>,
        unclaimed_rewards: u64,
        cumulative_rewards: u64,
    }

    struct BondTierHistory has copy, store {
        total_amount: u64,
        total_convertible_share: u64,
        total_count: u64,
    }

    struct Metadata has store, key {
        id: 0x2::object::UID,
        version: u64,
        tier: 0x2::table::Table<u64, u64>,
        total_bond_tier: u64,
        total_stake_supply: u64,
        total_unstake_supply: u64,
        total_convertible_shares: u64,
        total_bonds: u64,
        max_stake_history_value: 0x2::table::Table<u64, u64>,
        max_unstake_history_value: 0x2::table::Table<u64, u64>,
        max_add_share_history_value: 0x2::table::Table<u64, u64>,
        max_remove_convertible_share_history_value: 0x2::table::Table<u64, u64>,
        max_bond_history_tier_value: 0x2::table::Table<u64, vector<BondTierHistory>>,
        max_bond_history_value: 0x2::table::Table<u64, u64>,
    }

    public(friend) fun transfer(arg0: ConvertibleBond, arg1: address) {
        0x2::transfer::transfer<ConvertibleBond>(arg0, arg1);
    }

    fun add_bond_tiers_to_epoch(arg0: &mut Metadata, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg1 > 0, 200);
        let v1 = arg1 - 1;
        if (0x2::table::contains<u64, vector<BondTierHistory>>(&arg0.max_bond_history_tier_value, v0)) {
            let v2 = 0x2::table::borrow_mut<u64, vector<BondTierHistory>>(&mut arg0.max_bond_history_tier_value, v0);
            assert!(0x1::vector::length<BondTierHistory>(v2) > v1, 200);
            let v3 = 0x1::vector::borrow_mut<BondTierHistory>(v2, v1);
            v3.total_amount = v3.total_amount + arg2;
            v3.total_count = v3.total_count + 1;
        } else {
            let v4 = 0x1::vector::empty<BondTierHistory>();
            let v5 = 0;
            while (v5 < get_total_bond_tier(arg0)) {
                let v6 = if (v5 == v1) {
                    BondTierHistory{total_amount: arg2, total_convertible_share: arg3, total_count: 1}
                } else {
                    BondTierHistory{total_amount: 0, total_convertible_share: 0, total_count: 0}
                };
                0x1::vector::push_back<BondTierHistory>(&mut v4, v6);
                v5 = v5 + 1;
            };
            0x2::table::add<u64, vector<BondTierHistory>>(&mut arg0.max_bond_history_tier_value, v0, v4);
        };
    }

    fun add_bond_to_epoch(arg0: &mut Metadata, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg1);
        if (0x2::table::contains<u64, u64>(&arg0.max_bond_history_value, v0)) {
            let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.max_bond_history_value, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.max_bond_history_value, v0, 1);
        };
    }

    fun add_share_to_epoch(arg0: &mut Metadata, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (0x2::table::contains<u64, u64>(&arg0.max_stake_history_value, v0)) {
            let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.max_stake_history_value, v0);
            *v1 = *v1 + arg1;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.max_stake_history_value, v0, arg1);
        };
    }

    public(friend) fun add_stake_convertible_bond(arg0: &mut Metadata, arg1: &mut ConvertibleBond, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::url::Url, arg7: &0x2::tx_context::TxContext) {
        let v0 = arg4 - arg1.value;
        let v1 = arg5 - arg1.shares;
        add_stake_to_epoch(arg0, v0, arg7);
        add_share_to_epoch(arg0, v1, arg7);
        arg0.total_stake_supply = arg0.total_stake_supply + v0;
        arg0.total_convertible_shares = arg0.total_convertible_shares + v0;
        if (arg1.tier != arg3) {
            remove_bond_tiers_to_epoch(arg0, arg1.tier, arg1.value, arg1.shares, arg7);
            add_bond_tiers_to_epoch(arg0, arg3, arg4, arg5, arg7);
        } else {
            update_bond_tiers_to_epoch(arg0, arg1.tier, v0, v1, true, arg7);
        };
        arg1.name = arg2;
        arg1.tier = arg3;
        arg1.value = arg4;
        arg1.shares = arg5;
        arg1.image_url = arg6;
    }

    fun add_stake_to_epoch(arg0: &mut Metadata, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (0x2::table::contains<u64, u64>(&arg0.max_stake_history_value, v0)) {
            let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.max_stake_history_value, v0);
            *v1 = *v1 + arg1;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.max_stake_history_value, v0, arg1);
        };
    }

    fun add_unstake_to_epoch(arg0: &mut Metadata, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (0x2::table::contains<u64, u64>(&arg0.max_add_share_history_value, v0)) {
            let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.max_add_share_history_value, v0);
            *v1 = *v1 + arg1;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.max_add_share_history_value, v0, arg1);
        };
    }

    public(friend) fun convert_convertible_bond(arg0: &mut Metadata, arg1: &mut ConvertibleBond, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::url::Url, arg7: bool, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        let v0 = arg1.value - arg4;
        let v1 = arg1.shares - arg5;
        add_unstake_to_epoch(arg0, v0, arg9);
        remove_share_to_epoch(arg0, v1, arg9);
        arg0.total_convertible_shares = arg0.total_convertible_shares - v0;
        arg0.total_stake_supply = arg0.total_stake_supply - v0;
        if (arg1.tier != arg3) {
            remove_bond_tiers_to_epoch(arg0, arg1.tier, arg1.value, arg1.shares, arg9);
            add_bond_tiers_to_epoch(arg0, arg3, arg4, arg5, arg9);
        } else {
            update_bond_tiers_to_epoch(arg0, arg1.tier, v0, v1, false, arg9);
        };
        let v2 = BondConvertEvent{
            id                      : 0x2::object::uid_to_inner(&arg1.id),
            name                    : arg2,
            old_tier                : arg1.tier,
            new_tier                : arg3,
            remaining_stake_assets  : arg4,
            remaining_shares        : arg5,
            converted_stake_assets  : v0,
            converted_shares        : v1,
            unmature_conversion     : arg7,
            conversion_fee          : arg8,
            conversion_timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg9),
            unlock_time             : arg1.unlock_time,
            owner                   : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<BondConvertEvent>(v2);
        arg1.name = arg2;
        arg1.tier = arg3;
        arg1.value = arg4;
        arg1.shares = arg5;
        arg1.image_url = arg6;
    }

    public(friend) fun create_metadata(arg0: &mut 0x2::tx_context::TxContext) : Metadata {
        Metadata{
            id                                         : 0x2::object::new(arg0),
            version                                    : 1,
            tier                                       : 0x2::table::new<u64, u64>(arg0),
            total_bond_tier                            : 3,
            total_stake_supply                         : 0,
            total_unstake_supply                       : 0,
            total_convertible_shares                   : 0,
            total_bonds                                : 0,
            max_stake_history_value                    : 0x2::table::new<u64, u64>(arg0),
            max_unstake_history_value                  : 0x2::table::new<u64, u64>(arg0),
            max_add_share_history_value                : 0x2::table::new<u64, u64>(arg0),
            max_remove_convertible_share_history_value : 0x2::table::new<u64, u64>(arg0),
            max_bond_history_tier_value                : 0x2::table::new<u64, vector<BondTierHistory>>(arg0),
            max_bond_history_value                     : 0x2::table::new<u64, u64>(arg0),
        }
    }

    public fun get_base_multiplier(arg0: &ConvertibleBond) : u64 {
        arg0.base_multiplier
    }

    public fun get_bond_epoch_snapshot_value(arg0: &EpochSnapshot) : (u64, u64, u64, u64) {
        (arg0.epoch, arg0.amount, arg0.multiplier, arg0.time_weight)
    }

    public fun get_cumulative_rewards(arg0: &ConvertibleBond) : u64 {
        arg0.cumulative_rewards
    }

    public fun get_duration(arg0: &ConvertibleBond) : u64 {
        arg0.duration
    }

    public fun get_epoch_snapshots(arg0: &ConvertibleBond) : vector<EpochSnapshot> {
        arg0.epoch_snapshots
    }

    public fun get_image_url(arg0: &ConvertibleBond) : 0x2::url::Url {
        arg0.image_url
    }

    public fun get_last_claimed_epoch(arg0: &ConvertibleBond) : u64 {
        arg0.last_claimed_epoch
    }

    public(friend) fun get_max_supply_for_stake_2epochs(arg0: &Metadata, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::epoch(arg1);
        let v1 = 0;
        if (0x2::table::contains<u64, u64>(&arg0.max_stake_history_value, v0)) {
            v1 = *0x2::table::borrow<u64, u64>(&arg0.max_stake_history_value, v0);
        };
        if (v0 > 0 && 0x2::table::contains<u64, u64>(&arg0.max_stake_history_value, v0 - 1)) {
            v1 = v1 + *0x2::table::borrow<u64, u64>(&arg0.max_stake_history_value, v0 - 1);
        };
        v1
    }

    public(friend) fun get_max_supply_for_unstake_2epochs(arg0: &Metadata, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::epoch(arg1);
        let v1 = 0;
        if (0x2::table::contains<u64, u64>(&arg0.max_unstake_history_value, v0)) {
            v1 = *0x2::table::borrow<u64, u64>(&arg0.max_unstake_history_value, v0);
        };
        if (v0 > 0 && 0x2::table::contains<u64, u64>(&arg0.max_unstake_history_value, v0 - 1)) {
            v1 = v1 + *0x2::table::borrow<u64, u64>(&arg0.max_unstake_history_value, v0 - 1);
        };
        v1
    }

    public fun get_name(arg0: &ConvertibleBond) : 0x1::string::String {
        arg0.name
    }

    public fun get_shares(arg0: &ConvertibleBond) : u64 {
        arg0.shares
    }

    public fun get_start_epoch(arg0: &ConvertibleBond) : u64 {
        arg0.start_epoch
    }

    public fun get_total_bond_tier(arg0: &Metadata) : u64 {
        arg0.total_bond_tier
    }

    public fun get_total_convertible_shares(arg0: &Metadata) : u64 {
        arg0.total_convertible_shares
    }

    public fun get_total_stake_supply(arg0: &Metadata) : u64 {
        arg0.total_stake_supply
    }

    public fun get_total_unstake_supply(arg0: &Metadata) : u64 {
        arg0.total_unstake_supply
    }

    public fun get_unclaimed_rewards(arg0: &ConvertibleBond) : u64 {
        arg0.unclaimed_rewards
    }

    public fun get_unlock_time(arg0: &ConvertibleBond) : u64 {
        arg0.unlock_time
    }

    public fun get_value(arg0: &ConvertibleBond) : u64 {
        arg0.value
    }

    public fun is_compensation(arg0: &ConvertibleBond) : bool {
        arg0.compensation
    }

    public fun is_unlocked(arg0: &ConvertibleBond, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time
    }

    fun remove_bond_tiers_to_epoch(arg0: &mut Metadata, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg1 > 0, 200);
        let v1 = arg1 - 1;
        if (0x2::table::contains<u64, vector<BondTierHistory>>(&arg0.max_bond_history_tier_value, v0)) {
            let v2 = 0x2::table::borrow_mut<u64, vector<BondTierHistory>>(&mut arg0.max_bond_history_tier_value, v0);
            assert!(0x1::vector::length<BondTierHistory>(v2) > v1, 200);
            let v3 = 0x1::vector::borrow_mut<BondTierHistory>(v2, v1);
            v3.total_amount = v3.total_amount - arg2;
            v3.total_convertible_share = v3.total_convertible_share - arg3;
            v3.total_count = v3.total_count - 1;
        };
    }

    fun remove_bond_to_epoch(arg0: &mut Metadata, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg1);
        if (0x2::table::contains<u64, u64>(&arg0.max_bond_history_value, v0)) {
            let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.max_bond_history_value, v0);
            *v1 = *v1 - 1;
        };
    }

    fun remove_share_to_epoch(arg0: &mut Metadata, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (0x2::table::contains<u64, u64>(&arg0.max_remove_convertible_share_history_value, v0)) {
            let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.max_remove_convertible_share_history_value, v0);
            *v1 = *v1 + arg1;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.max_remove_convertible_share_history_value, v0, arg1);
        };
    }

    public(friend) fun unwrap_convertible_bond(arg0: &mut Metadata, arg1: ConvertibleBond, arg2: u64, arg3: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let ConvertibleBond {
            id                 : v0,
            name               : v1,
            tier               : v2,
            duration           : _,
            unlock_time        : _,
            value              : v5,
            shares             : v6,
            compensation       : _,
            image_url          : _,
            start_epoch        : _,
            base_multiplier    : _,
            last_claimed_epoch : _,
            epoch_snapshots    : _,
            unclaimed_rewards  : _,
            cumulative_rewards : _,
        } = arg1;
        let v15 = v0;
        add_unstake_to_epoch(arg0, v5, arg3);
        remove_share_to_epoch(arg0, v6, arg3);
        remove_bond_tiers_to_epoch(arg0, v2, v5, v6, arg3);
        remove_bond_to_epoch(arg0, arg3);
        arg0.total_stake_supply = arg0.total_stake_supply - v5;
        arg0.total_convertible_shares = arg0.total_convertible_shares - v6;
        arg0.total_bonds = arg0.total_bonds - 1;
        let v16 = BondBurnedEvent{
            id                : 0x2::object::uid_to_inner(&v15),
            name              : v1,
            tier              : v2,
            value             : v5,
            shares            : v6,
            burn_timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg3),
            fee               : arg2,
        };
        0x2::event::emit<BondBurnedEvent>(v16);
        0x2::object::delete(v15);
        (v5, v6, arg2)
    }

    public(friend) fun update_bond_epoch_snapshot_on_stake(arg0: &mut ConvertibleBond, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        if (!0x1::vector::is_empty<EpochSnapshot>(&arg0.epoch_snapshots)) {
            let v0 = 0x1::vector::length<EpochSnapshot>(&arg0.epoch_snapshots) - 1;
            if (0x1::vector::borrow<EpochSnapshot>(&arg0.epoch_snapshots, v0).epoch == arg1) {
                let v1 = 0x1::vector::borrow_mut<EpochSnapshot>(&mut arg0.epoch_snapshots, v0);
                v1.amount = v1.amount + arg2;
            } else {
                let v2 = EpochSnapshot{
                    epoch       : arg1,
                    amount      : arg2,
                    multiplier  : arg3,
                    time_weight : arg4,
                };
                0x1::vector::push_back<EpochSnapshot>(&mut arg0.epoch_snapshots, v2);
            };
        } else {
            let v3 = EpochSnapshot{
                epoch       : arg1,
                amount      : arg2,
                multiplier  : arg3,
                time_weight : arg4,
            };
            0x1::vector::push_back<EpochSnapshot>(&mut arg0.epoch_snapshots, v3);
        };
    }

    public(friend) fun update_bond_epoch_snapshot_on_unstake(arg0: &mut ConvertibleBond, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        if (!0x1::vector::is_empty<EpochSnapshot>(&arg0.epoch_snapshots)) {
            let v0 = 0x1::vector::length<EpochSnapshot>(&arg0.epoch_snapshots) - 1;
            if (0x1::vector::borrow<EpochSnapshot>(&arg0.epoch_snapshots, v0).epoch == arg1) {
                let v1 = 0x1::vector::borrow_mut<EpochSnapshot>(&mut arg0.epoch_snapshots, v0);
                v1.amount = v1.amount - arg2;
            } else {
                let v2 = EpochSnapshot{
                    epoch       : arg1,
                    amount      : arg0.value - arg2,
                    multiplier  : arg3,
                    time_weight : arg4,
                };
                0x1::vector::push_back<EpochSnapshot>(&mut arg0.epoch_snapshots, v2);
            };
        };
    }

    fun update_bond_tiers_to_epoch(arg0: &mut Metadata, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        assert!(arg1 > 0, 200);
        let v1 = arg1 - 1;
        if (0x2::table::contains<u64, vector<BondTierHistory>>(&arg0.max_bond_history_tier_value, v0)) {
            let v2 = 0x2::table::borrow_mut<u64, vector<BondTierHistory>>(&mut arg0.max_bond_history_tier_value, v0);
            assert!(0x1::vector::length<BondTierHistory>(v2) > v1, 200);
            let v3 = 0x1::vector::borrow_mut<BondTierHistory>(v2, v1);
            if (arg4) {
                v3.total_amount = v3.total_amount + arg2;
                v3.total_convertible_share = v3.total_convertible_share + arg3;
            } else {
                v3.total_amount = v3.total_amount - arg2;
                v3.total_convertible_share = v3.total_convertible_share - arg3;
            };
        };
    }

    public(friend) fun update_cumulative_rewards(arg0: &mut ConvertibleBond, arg1: u64) {
        arg0.cumulative_rewards = arg0.cumulative_rewards + arg1;
    }

    public(friend) fun update_last_claimed_epoch(arg0: &mut ConvertibleBond, arg1: u64) {
        arg0.last_claimed_epoch = arg0.last_claimed_epoch + arg1;
    }

    public(friend) fun update_unclaimed_rewards(arg0: &mut ConvertibleBond, arg1: u64) {
        arg0.unclaimed_rewards = arg0.unclaimed_rewards + arg1;
    }

    public(friend) fun withdraw_stake_convertible_bond(arg0: &mut Metadata, arg1: &mut ConvertibleBond, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::url::Url, arg7: bool, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        let v0 = arg1.value - arg4;
        let v1 = arg1.shares - arg5;
        add_unstake_to_epoch(arg0, v0, arg9);
        remove_share_to_epoch(arg0, v1, arg9);
        arg0.total_stake_supply = arg0.total_stake_supply - v0;
        arg0.total_unstake_supply = arg0.total_unstake_supply + v0;
        arg0.total_convertible_shares = arg0.total_convertible_shares - v0;
        if (arg1.tier != arg3) {
            remove_bond_tiers_to_epoch(arg0, arg1.tier, arg1.value, arg1.shares, arg9);
            add_bond_tiers_to_epoch(arg0, arg3, arg4, arg5, arg9);
        } else {
            update_bond_tiers_to_epoch(arg0, arg1.tier, v0, v1, false, arg9);
        };
        let v2 = BondWithdrawalEvent{
            id                      : 0x2::object::uid_to_inner(&arg1.id),
            name                    : arg2,
            old_tier                : arg1.tier,
            new_tier                : arg3,
            withdrawn_stake_assets  : v0,
            remaining_stake_assets  : arg4,
            old_shares              : arg1.shares,
            new_shares              : arg5,
            unmature_withdrawal     : arg7,
            withdrawal_fee          : arg8,
            withdrawal_timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg9),
            unlock_time             : arg1.unlock_time,
            owner                   : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<BondWithdrawalEvent>(v2);
        arg1.name = arg2;
        arg1.tier = arg3;
        arg1.value = arg4;
        arg1.shares = arg5;
        arg1.image_url = arg6;
    }

    public(friend) fun wrap_convertible_bond(arg0: &mut Metadata, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x2::url::Url, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : ConvertibleBond {
        add_stake_to_epoch(arg0, arg3, arg10);
        add_share_to_epoch(arg0, arg4, arg10);
        add_bond_to_epoch(arg0, arg10);
        add_bond_tiers_to_epoch(arg0, arg2, arg3, arg4, arg10);
        arg0.total_stake_supply = arg0.total_stake_supply + arg3;
        arg0.total_convertible_shares = arg0.total_convertible_shares + arg4;
        arg0.total_bonds = arg0.total_bonds + 1;
        let v0 = 0x2::tx_context::epoch(arg10);
        let v1 = ConvertibleBond{
            id                 : 0x2::object::new(arg10),
            name               : arg1,
            tier               : arg2,
            duration           : arg7,
            unlock_time        : arg8,
            value              : arg3,
            shares             : arg4,
            compensation       : arg5,
            image_url          : arg6,
            start_epoch        : v0,
            base_multiplier    : arg9,
            last_claimed_epoch : v0,
            epoch_snapshots    : 0x1::vector::empty<EpochSnapshot>(),
            unclaimed_rewards  : 0,
            cumulative_rewards : 0,
        };
        let v2 = EpochSnapshot{
            epoch       : v0,
            amount      : arg3,
            multiplier  : 0,
            time_weight : 0,
        };
        0x1::vector::push_back<EpochSnapshot>(&mut v1.epoch_snapshots, v2);
        let v3 = BondMintedEvent{
            id          : 0x2::object::uid_to_inner(&v1.id),
            name        : v1.name,
            value       : v1.value,
            tier        : v1.tier,
            shares      : v1.shares,
            unlock_time : v1.unlock_time,
            owner       : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<BondMintedEvent>(v3);
        v1
    }

    // decompiled from Move bytecode v6
}

