module 0xb010ea3a72cfb89e3b436921b0c521639193daf004c39c9d18f8ba385606492e::minter {
    struct TransferOwnership has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct SetPoolAccountA has copy, drop {
        pool_account_a: address,
    }

    struct SetPoolAccountB has copy, drop {
        pool_account_b: address,
    }

    struct SetAcceptedByA has copy, drop {
        token: 0x1::type_name::TypeName,
        accepted: bool,
    }

    struct SetAcceptedByB has copy, drop {
        token: 0x1::type_name::TypeName,
        accepted: bool,
    }

    struct MintRequest has copy, drop {
        transferred_token: 0x1::type_name::TypeName,
        for_token: 0x1::type_name::TypeName,
        requestor: address,
        pool: address,
        amount: u64,
        preprice: u64,
        slippage: u64,
    }

    struct RedeemRequest has copy, drop {
        transferred_token: 0x1::type_name::TypeName,
        for_token: 0x1::type_name::TypeName,
        requestor: address,
        pool: address,
        amount: u64,
        preprice: u64,
        slippage: u64,
    }

    struct State has key {
        id: 0x2::object::UID,
        version: u64,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        owner: address,
        pool_account_a: address,
        pool_account_b: address,
        accepted_by_a: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        accepted_by_b: 0x2::table::Table<0x1::type_name::TypeName, bool>,
    }

    public fun accepted_by_a(arg0: &State, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_by_a, arg1)
    }

    public fun accepted_by_b(arg0: &State, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_by_b, arg1)
    }

    fun check_owner(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    fun check_version(arg0: &State) {
        assert!(arg0.version == 1, 100);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = State{
            id             : 0x2::object::new(arg0),
            version        : 1,
            upgrade_cap_id : 0x1::option::none<0x2::object::ID>(),
            owner          : v0,
            pool_account_a : v0,
            pool_account_b : v0,
            accepted_by_a  : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            accepted_by_b  : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
        };
        0x2::transfer::share_object<State>(v1);
    }

    entry fun init_upgrade_cap_id(arg0: &mut State, arg1: &0x2::package::UpgradeCap, arg2: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.upgrade_cap_id), 102);
        let v0 = 0x2::package::upgrade_package(arg1);
        assert!(0x2::object::id_to_address(&v0) == package_address(arg0), 108);
        arg0.upgrade_cap_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg1));
    }

    entry fun migrate(arg0: &mut State, arg1: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg1);
        assert!(arg0.version < 1, 100);
        arg0.version = 1;
    }

    public fun owner(arg0: &State) : address {
        arg0.owner
    }

    public fun package_address(arg0: &State) : address {
        let v0 = 0x1::type_name::get_with_original_ids<State>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    public fun pool_account_a(arg0: &State) : address {
        arg0.pool_account_a
    }

    public fun pool_account_b(arg0: &State) : address {
        arg0.pool_account_b
    }

    public fun request_to_mint<T0, T1>(arg0: &State, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_by_a, v0), 200);
        assert!(0x2::clock::timestamp_ms(arg6) / 1000 <= arg5 + 59, 203);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 202);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg2, arg7), arg0.pool_account_a);
        let v1 = MintRequest{
            transferred_token : v0,
            for_token         : 0x1::type_name::get<T1>(),
            requestor         : 0x2::tx_context::sender(arg7),
            pool              : arg0.pool_account_a,
            amount            : arg2,
            preprice          : arg3,
            slippage          : arg4,
        };
        0x2::event::emit<MintRequest>(v1);
    }

    public fun request_to_redeem<T0, T1>(arg0: &State, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_by_b, v0), 201);
        assert!(0x2::clock::timestamp_ms(arg6) / 1000 <= arg5 + 59, 203);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 202);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg2, arg7), arg0.pool_account_b);
        let v1 = RedeemRequest{
            transferred_token : v0,
            for_token         : 0x1::type_name::get<T1>(),
            requestor         : 0x2::tx_context::sender(arg7),
            pool              : arg0.pool_account_b,
            amount            : arg2,
            preprice          : arg3,
            slippage          : arg4,
        };
        0x2::event::emit<RedeemRequest>(v1);
    }

    entry fun set_accepted_by_a<T0>(arg0: &mut State, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_by_a, v0)) {
            if (!arg1) {
                0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.accepted_by_a, v0);
            };
        } else if (arg1) {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.accepted_by_a, v0, true);
        };
        let v1 = SetAcceptedByA{
            token    : v0,
            accepted : arg1,
        };
        0x2::event::emit<SetAcceptedByA>(v1);
    }

    entry fun set_accepted_by_b<T0>(arg0: &mut State, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.accepted_by_b, v0)) {
            if (!arg1) {
                0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.accepted_by_b, v0);
            };
        } else if (arg1) {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.accepted_by_b, v0, true);
        };
        let v1 = SetAcceptedByB{
            token    : v0,
            accepted : arg1,
        };
        0x2::event::emit<SetAcceptedByB>(v1);
    }

    entry fun set_pool_account_a(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.pool_account_a = arg1;
        let v0 = SetPoolAccountA{pool_account_a: arg1};
        0x2::event::emit<SetPoolAccountA>(v0);
    }

    entry fun set_pool_account_b(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.pool_account_b = arg1;
        let v0 = SetPoolAccountB{pool_account_b: arg1};
        0x2::event::emit<SetPoolAccountB>(v0);
    }

    entry fun transfer_ownership(arg0: &mut State, arg1: address, arg2: 0x2::package::UpgradeCap, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(&arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.upgrade_cap_id, &v0), 108);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg2, arg1);
        arg0.owner = arg1;
        let v1 = TransferOwnership{
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<TransferOwnership>(v1);
    }

    public fun upgrade_cap_id(arg0: &State) : 0x1::option::Option<0x2::object::ID> {
        arg0.upgrade_cap_id
    }

    public fun version(arg0: &State) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

