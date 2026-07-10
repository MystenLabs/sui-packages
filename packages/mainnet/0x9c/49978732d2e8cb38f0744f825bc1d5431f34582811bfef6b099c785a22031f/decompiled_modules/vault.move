module 0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        policy_id: 0x2::object::ID,
        usdc: 0x2::balance::Balance<T0>,
        principal: u64,
        allowed_positions: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct PosKey has copy, drop, store {
        t: 0x1::type_name::TypeName,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        agent: address,
        policy_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        principal: u64,
    }

    struct OwnerWithdrew has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        position: bool,
    }

    struct BorrowReceipt {
        vault_id: 0x2::object::ID,
        amount: u64,
        protocol: 0x1::string::String,
    }

    struct Borrowed has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        protocol: 0x1::string::String,
    }

    struct PositionReturned has copy, drop {
        vault_id: 0x2::object::ID,
        position: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun agent<T0>(arg0: &Vault<T0>) : address {
        arg0.agent
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun allows_position<T0>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_positions, arg1)
    }

    public fun borrow_for_supply<T0>(arg0: &mut Vault<T0>, arg1: &0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::AgentPolicy, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, BorrowReceipt) {
        assert!(0x2::object::id<0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::AgentPolicy>(arg1) == arg0.policy_id, 1);
        0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::assert_active(arg1, arg2, arg4, arg3, arg5);
        assert!(0x2::balance::value<T0>(&arg0.usdc) >= arg3, 4);
        let v0 = Borrowed{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : arg3,
            protocol : arg4,
        };
        0x2::event::emit<Borrowed>(v0);
        let v1 = BorrowReceipt{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : arg3,
            protocol : arg4,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc, arg3), arg5), v1)
    }

    public fun borrow_position<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::AgentPolicy, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, BorrowReceipt) {
        assert!(0x2::object::id<0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::AgentPolicy>(arg1) == arg0.policy_id, 1);
        0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::assert_active(arg1, arg2, arg3, 0, arg4);
        let v0 = PosKey{t: 0x1::type_name::get<T1>()};
        assert!(0x2::dynamic_field::exists_<PosKey>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_field::remove<PosKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v0);
        let v2 = 0x2::balance::value<T1>(&v1);
        let v3 = Borrowed{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : v2,
            protocol : arg3,
        };
        0x2::event::emit<Borrowed>(v3);
        let v4 = BorrowReceipt{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : v2,
            protocol : arg3,
        };
        (0x2::coin::from_balance<T1>(v1, arg4), v4)
    }

    public fun create_vault<T0>(arg0: &0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::AgentPolicy, arg1: vector<0x1::type_name::TypeName>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::owner(arg0), 3);
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg1);
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v0, &v2)) {
                0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg1);
        let v3 = Vault<T0>{
            id                : 0x2::object::new(arg2),
            owner             : 0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::owner(arg0),
            agent             : 0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::agent(arg0),
            policy_id         : 0x2::object::id<0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::AgentPolicy>(arg0),
            usdc              : 0x2::balance::zero<T0>(),
            principal         : 0,
            allowed_positions : v0,
        };
        let v4 = VaultCreated{
            vault_id  : 0x2::object::id<Vault<T0>>(&v3),
            owner     : v3.owner,
            agent     : v3.agent,
            policy_id : v3.policy_id,
        };
        0x2::event::emit<VaultCreated>(v4);
        0x2::transfer::share_object<Vault<T0>>(v3);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.usdc, 0x2::coin::into_balance<T0>(arg1));
        arg0.principal = arg0.principal + v0;
        let v1 = Deposited{
            vault_id  : 0x2::object::id<Vault<T0>>(arg0),
            amount    : v0,
            principal : arg0.principal,
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun has_position<T0, T1>(arg0: &Vault<T0>) : bool {
        let v0 = PosKey{t: 0x1::type_name::get<T1>()};
        0x2::dynamic_field::exists_<PosKey>(&arg0.id, v0)
    }

    public fun idle<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.usdc)
    }

    public fun owner_withdraw_position<T0, T1>(arg0: &mut Vault<T0>, arg1: &0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::owner_cap_policy_id(arg1) == arg0.policy_id, 3);
        let v0 = PosKey{t: 0x1::type_name::get<T1>()};
        assert!(0x2::dynamic_field::exists_<PosKey>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_field::remove<PosKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v0);
        let v2 = OwnerWithdrew{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : 0x2::balance::value<T1>(&v1),
            position : true,
        };
        0x2::event::emit<OwnerWithdrew>(v2);
        0x2::coin::from_balance<T1>(v1, arg2)
    }

    public fun owner_withdraw_usdc<T0>(arg0: &mut Vault<T0>, arg1: &0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy::owner_cap_policy_id(arg1) == arg0.policy_id, 3);
        assert!(0x2::balance::value<T0>(&arg0.usdc) >= arg2, 4);
        let v0 = if (arg0.principal >= arg2) {
            arg0.principal - arg2
        } else {
            0
        };
        arg0.principal = v0;
        let v1 = OwnerWithdrew{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : arg2,
            position : false,
        };
        0x2::event::emit<OwnerWithdrew>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc, arg2), arg3)
    }

    public fun policy_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun position_value<T0, T1>(arg0: &Vault<T0>) : u64 {
        let v0 = PosKey{t: 0x1::type_name::get<T1>()};
        if (0x2::dynamic_field::exists_<PosKey>(&arg0.id, v0)) {
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<PosKey, 0x2::balance::Balance<T1>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun principal<T0>(arg0: &Vault<T0>) : u64 {
        arg0.principal
    }

    public fun return_position<T0, T1>(arg0: &mut Vault<T0>, arg1: BorrowReceipt, arg2: 0x2::coin::Coin<T1>) {
        let BorrowReceipt {
            vault_id : v0,
            amount   : _,
            protocol : _,
        } = arg1;
        assert!(v0 == 0x2::object::id<Vault<T0>>(arg0), 1);
        let v3 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_positions, &v3), 2);
        let v4 = PosKey{t: v3};
        if (0x2::dynamic_field::exists_<PosKey>(&arg0.id, v4)) {
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<PosKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v4), 0x2::coin::into_balance<T1>(arg2));
        } else {
            0x2::dynamic_field::add<PosKey, 0x2::balance::Balance<T1>>(&mut arg0.id, v4, 0x2::coin::into_balance<T1>(arg2));
        };
        let v5 = PositionReturned{
            vault_id : v0,
            position : v3,
            amount   : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<PositionReturned>(v5);
    }

    public fun return_usdc<T0>(arg0: &mut Vault<T0>, arg1: BorrowReceipt, arg2: 0x2::coin::Coin<T0>) {
        let BorrowReceipt {
            vault_id : v0,
            amount   : _,
            protocol : _,
        } = arg1;
        assert!(v0 == 0x2::object::id<Vault<T0>>(arg0), 1);
        0x2::balance::join<T0>(&mut arg0.usdc, 0x2::coin::into_balance<T0>(arg2));
    }

    // decompiled from Move bytecode v7
}

