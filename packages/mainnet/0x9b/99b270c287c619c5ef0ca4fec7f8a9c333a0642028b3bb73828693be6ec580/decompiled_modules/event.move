module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event {
    struct NewCenterEvent has copy, drop {
        point_type: 0x1::ascii::String,
        id: 0x2::object::ID,
        admin_id: 0x2::object::ID,
    }

    struct NewPoolEvent<phantom T0> has copy, drop {
        asset_type: 0x1::ascii::String,
        id: 0x2::object::ID,
    }

    struct StakeEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        account: address,
        amount: u64,
        balance: u64,
    }

    struct UnstakeEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        account: address,
        amount: u64,
        balance: u64,
    }

    struct CumulateEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        account: address,
        points: u64,
        cumulant: u64,
    }

    struct ClaimEvent<phantom T0> has copy, drop {
        account: address,
        amount: u64,
    }

    struct MintEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        amount: u64,
        supply: u64,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        points: u64,
        supply: u64,
        origin: 0x1::option::Option<0x1::ascii::String>,
    }

    public(friend) fun emit_burn<T0>(arg0: u64, arg1: u64, arg2: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = if (0x1::option::is_some<0x1::type_name::TypeName>(&arg2)) {
            0x1::option::some<0x1::ascii::String>(0x1::type_name::into_string(0x1::option::destroy_some<0x1::type_name::TypeName>(arg2)))
        } else {
            0x1::option::destroy_none<0x1::type_name::TypeName>(arg2);
            0x1::option::none<0x1::ascii::String>()
        };
        let v1 = BurnEvent<T0>{
            points : arg0,
            supply : arg1,
            origin : v0,
        };
        0x2::event::emit<BurnEvent<T0>>(v1);
    }

    public(friend) fun emit_claim<T0>(arg0: address, arg1: u64) {
        let v0 = ClaimEvent<T0>{
            account : arg0,
            amount  : arg1,
        };
        0x2::event::emit<ClaimEvent<T0>>(v0);
    }

    public(friend) fun emit_cumulate<T0>(arg0: &0x2::object::ID, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: u64) {
        let v0 = CumulateEvent<T0>{
            pool_id    : *arg0,
            asset_type : arg1,
            account    : arg2,
            points     : arg3,
            cumulant   : arg4,
        };
        0x2::event::emit<CumulateEvent<T0>>(v0);
    }

    public(friend) fun emit_mint<T0>(arg0: &0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = MintEvent<T0>{
            pool_id    : *arg0,
            asset_type : arg1,
            amount     : arg2,
            supply     : arg3,
        };
        0x2::event::emit<MintEvent<T0>>(v0);
    }

    public(friend) fun emit_new_center<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewCenterEvent{
            point_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            id         : arg0,
            admin_id   : arg1,
        };
        0x2::event::emit<NewCenterEvent>(v0);
    }

    public(friend) fun emit_new_pool<T0, T1>(arg0: 0x2::object::ID) {
        let v0 = NewPoolEvent<T0>{
            asset_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            id         : arg0,
        };
        0x2::event::emit<NewPoolEvent<T0>>(v0);
    }

    public(friend) fun emit_stake<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address, arg3: u64, arg4: u64) {
        let v0 = StakeEvent<T0>{
            pool_id    : arg0,
            asset_type : 0x1::type_name::into_string(arg1),
            account    : arg2,
            amount     : arg3,
            balance    : arg4,
        };
        0x2::event::emit<StakeEvent<T0>>(v0);
    }

    public(friend) fun emit_unstake<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address, arg3: u64, arg4: u64) {
        let v0 = UnstakeEvent<T0>{
            pool_id    : arg0,
            asset_type : 0x1::type_name::into_string(arg1),
            account    : arg2,
            amount     : arg3,
            balance    : arg4,
        };
        0x2::event::emit<UnstakeEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

