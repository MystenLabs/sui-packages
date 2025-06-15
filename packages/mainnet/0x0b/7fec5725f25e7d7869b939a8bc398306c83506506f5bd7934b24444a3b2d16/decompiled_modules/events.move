module 0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::events {
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

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_burned_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = BurnedEventV1{
            vault      : arg0,
            input      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            output     : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
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

    // decompiled from Move bytecode v6
}

