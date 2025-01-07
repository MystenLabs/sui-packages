module 0x74d4b9ed7b160005a5e6d8bfd4064b22850a109153ca88a2e053784cd569d646::stake_cb {
    struct BondMintedEvent has copy, drop {
        id: 0x2::object::ID,
        value: u64,
        tier: u64,
        conversion_shares: u64,
        unlock_epoch: u64,
        unstake_fee: u64,
        conversion_fee: u64,
    }

    struct BondBurnedEvent has copy, drop {
        id: 0x2::object::ID,
        value: u64,
        tier: u64,
        conversion_shares: u64,
        epoch: u64,
        unstake_fee: u64,
        conversion_fee: u64,
    }

    struct ConvertibleBond has key {
        id: 0x2::object::UID,
        tier: u64,
        unlock_epoch: u64,
        value: u64,
        conversion_shares: u64,
        unstake_fee: u64,
        conversion_fee: u64,
        convertible: bool,
    }

    struct Metadata has store, key {
        id: 0x2::object::UID,
        version: u64,
        tier: 0x2::table::Table<u64, u64>,
        total_stake_supply: u64,
        total_unstake_supply: u64,
        max_stake_history_value: 0x2::table::Table<u64, u64>,
        max_unstake_history_value: 0x2::table::Table<u64, u64>,
    }

    public(friend) fun transfer(arg0: ConvertibleBond, arg1: address) {
        0x2::transfer::transfer<ConvertibleBond>(arg0, arg1);
    }

    fun add_stake_to_epoch(arg0: &mut Metadata, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (0x2::table::contains<u64, u64>(&arg0.max_stake_history_value, v0)) {
            let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.max_stake_history_value, v0);
            *v1 = *v1 + arg1;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.max_stake_history_value, v0, arg1);
        };
    }

    public(friend) fun create_metadata(arg0: &mut 0x2::tx_context::TxContext) : Metadata {
        Metadata{
            id                        : 0x2::object::new(arg0),
            version                   : 1,
            tier                      : 0x2::table::new<u64, u64>(arg0),
            total_stake_supply        : 0,
            total_unstake_supply      : 0,
            max_stake_history_value   : 0x2::table::new<u64, u64>(arg0),
            max_unstake_history_value : 0x2::table::new<u64, u64>(arg0),
        }
    }

    public fun get_conversion_fee(arg0: &ConvertibleBond) : u64 {
        arg0.conversion_fee
    }

    public fun get_conversion_shares(arg0: &ConvertibleBond) : u64 {
        arg0.conversion_shares
    }

    public(friend) fun get_max_supply_for_stake_2epochs(arg0: &Metadata, arg1: &mut 0x2::tx_context::TxContext) : u64 {
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

    public(friend) fun get_max_supply_for_unstake_2epochs(arg0: &Metadata, arg1: &mut 0x2::tx_context::TxContext) : u64 {
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

    public fun get_total_stake_supply(arg0: &Metadata) : u64 {
        arg0.total_stake_supply
    }

    public fun get_total_unstake_supply(arg0: &Metadata) : u64 {
        arg0.total_unstake_supply
    }

    public fun get_unlock_epoch(arg0: &ConvertibleBond) : u64 {
        arg0.unlock_epoch
    }

    public fun get_unstake_fee(arg0: &ConvertibleBond) : u64 {
        arg0.unstake_fee
    }

    public fun get_value(arg0: &ConvertibleBond) : u64 {
        arg0.value
    }

    public fun is_convertible(arg0: &ConvertibleBond) : bool {
        arg0.convertible
    }

    public fun is_unlocked(arg0: &ConvertibleBond, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) >= arg0.unlock_epoch
    }

    public(friend) fun unwrap_convertible_bond(arg0: &mut Metadata, arg1: ConvertibleBond, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        let ConvertibleBond {
            id                : v0,
            tier              : v1,
            unlock_epoch      : _,
            value             : v3,
            conversion_shares : v4,
            unstake_fee       : v5,
            conversion_fee    : v6,
            convertible       : _,
        } = arg1;
        let v8 = v0;
        arg0.total_stake_supply = arg0.total_stake_supply - v3;
        let v9 = BondBurnedEvent{
            id                : 0x2::object::uid_to_inner(&v8),
            value             : v3,
            tier              : v1,
            conversion_shares : v4,
            epoch             : 0x2::tx_context::epoch(arg2),
            unstake_fee       : v5,
            conversion_fee    : v6,
        };
        0x2::event::emit<BondBurnedEvent>(v9);
        0x2::object::delete(v8);
        (v3, v5)
    }

    public(friend) fun wrap_convertible_bond(arg0: &mut Metadata, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : ConvertibleBond {
        add_stake_to_epoch(arg0, arg2, arg8);
        arg0.total_stake_supply = arg0.total_stake_supply + arg2;
        let v0 = ConvertibleBond{
            id                : 0x2::object::new(arg8),
            tier              : arg1,
            unlock_epoch      : arg7,
            value             : arg2,
            conversion_shares : arg5,
            unstake_fee       : arg6,
            conversion_fee    : arg4,
            convertible       : arg3,
        };
        let v1 = BondMintedEvent{
            id                : 0x2::object::uid_to_inner(&v0.id),
            value             : v0.value,
            tier              : v0.tier,
            conversion_shares : v0.conversion_shares,
            unlock_epoch      : v0.unlock_epoch,
            unstake_fee       : v0.unstake_fee,
            conversion_fee    : v0.conversion_fee,
        };
        0x2::event::emit<BondMintedEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

