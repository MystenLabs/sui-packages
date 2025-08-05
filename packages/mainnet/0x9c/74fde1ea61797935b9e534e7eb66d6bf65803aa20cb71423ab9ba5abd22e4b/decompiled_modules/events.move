module 0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreatedVaultEventV1 has copy, drop {
        vault: 0x2::object::ID,
        input: 0x1::ascii::String,
        output: 0x1::ascii::String,
        owner: address,
    }

    struct MintedEventV1 has copy, drop {
        vault: 0x2::object::ID,
        input: 0x1::ascii::String,
        output: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
    }

    struct BurnedEventV1 has copy, drop {
        vault: 0x2::object::ID,
        input: 0x1::ascii::String,
        output: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        amount_fee: u64,
    }

    struct DepositedRewardEventV1 has copy, drop {
        vault: 0x2::object::ID,
        reward: 0x1::ascii::String,
        amount: u64,
    }

    struct WithdrewRewardEventV1 has copy, drop {
        vault: 0x2::object::ID,
        reward: 0x1::ascii::String,
        amount: u64,
    }

    struct UpgradedVersionEventV1 has copy, drop {
        previous: u64,
        new: u64,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_burned_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = BurnedEventV1{
            vault      : arg0,
            input      : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            output     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount_in  : arg1,
            amount_out : arg2,
            amount_fee : arg3,
        };
        emit<BurnedEventV1>(v0);
    }

    public(friend) fun emit_created_vault_event<T0, T1>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CreatedVaultEventV1{
            vault  : arg0,
            input  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            output : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            owner  : arg1,
        };
        emit<CreatedVaultEventV1>(v0);
    }

    public(friend) fun emit_deposited_reward_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = DepositedRewardEventV1{
            vault  : arg0,
            reward : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount : arg1,
        };
        emit<DepositedRewardEventV1>(v0);
    }

    public(friend) fun emit_minted_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = MintedEventV1{
            vault      : arg0,
            input      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            output     : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            amount_in  : arg1,
            amount_out : arg2,
        };
        emit<MintedEventV1>(v0);
    }

    public(friend) fun emit_upgraded_version_event(arg0: u64, arg1: u64) {
        let v0 = UpgradedVersionEventV1{
            previous : arg0,
            new      : arg1,
        };
        emit<UpgradedVersionEventV1>(v0);
    }

    public(friend) fun emit_withdrew_reward_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = WithdrewRewardEventV1{
            vault  : arg0,
            reward : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount : arg1,
        };
        emit<WithdrewRewardEventV1>(v0);
    }

    // decompiled from Move bytecode v6
}

