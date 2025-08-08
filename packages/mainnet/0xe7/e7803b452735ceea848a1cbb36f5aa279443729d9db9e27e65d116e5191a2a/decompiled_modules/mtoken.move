module 0xe7e7803b452735ceea848a1cbb36f5aa279443729d9db9e27e65d116e5191a2a::mtoken {
    struct TransferOwnershipEvent has copy, drop {
        old_owner: address,
        new_owner: address,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct SetOperatorEvent has copy, drop {
        old_operator: address,
        new_operator: address,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct SetRevokerEvent has copy, drop {
        old_revoker: address,
        new_revoker: address,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct SetDelayEvent has copy, drop {
        old_delay: u64,
        new_delay: u64,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct ChangeMintBudgetEvent has copy, drop {
        delta: u64,
        is_incr: bool,
    }

    struct MintEvent has copy, drop {
        to_address: address,
        amount: u64,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct RedeemEvent has copy, drop {
        from_address: address,
        amount: u64,
    }

    struct BlockEvent has copy, drop {
        user_address: address,
    }

    struct UnblockEvent has copy, drop {
        user_address: address,
    }

    struct TransferOwnershipReq has key {
        id: 0x2::object::UID,
        new_owner: address,
        upgrade_cap: 0x2::package::UpgradeCap,
        et: u64,
    }

    struct SetOperatorReq has key {
        id: 0x2::object::UID,
        new_operator: address,
        et: u64,
    }

    struct SetRevokerReq has key {
        id: 0x2::object::UID,
        new_revoker: address,
        et: u64,
    }

    struct SetDelayReq has key {
        id: 0x2::object::UID,
        new_delay: u64,
        et: u64,
    }

    struct MintReq has key {
        id: 0x2::object::UID,
        recipient: address,
        amount: u64,
        et: u64,
    }

    struct State<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        deny_cap: 0x2::coin::DenyCapV2<T0>,
        owner: address,
        operator: address,
        revoker: address,
        delay: u64,
        mint_budget: u64,
    }

    public fun total_supply<T0>(arg0: &State<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    entry fun update_description<T0>(arg0: &State<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        0x2::coin::update_description<T0>(&arg0.treasury_cap, arg1, arg2);
    }

    entry fun update_icon_url<T0>(arg0: &State<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        0x2::coin::update_icon_url<T0>(&arg0.treasury_cap, arg1, arg2);
    }

    entry fun add_to_blocked_list<T0>(arg0: &mut State<T0>, arg1: address, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg3);
        0x2::coin::deny_list_v2_add<T0>(arg2, &mut arg0.deny_cap, arg1, arg3);
        let v0 = BlockEvent{user_address: arg1};
        0x2::event::emit<BlockEvent>(v0);
    }

    entry fun change_mint_budget<T0>(arg0: &mut State<T0>, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg3);
        if (arg2) {
            arg0.mint_budget = arg0.mint_budget + arg1;
        } else {
            arg0.mint_budget = arg0.mint_budget - arg1;
        };
        let v0 = ChangeMintBudgetEvent{
            delta   : arg1,
            is_incr : arg2,
        };
        0x2::event::emit<ChangeMintBudgetEvent>(v0);
    }

    fun check_effective_time(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        assert!(arg1 <= v0, 104);
        assert!(arg1 + 3600 > v0, 109);
    }

    fun check_operator<T0>(arg0: &State<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 102);
    }

    fun check_owner<T0>(arg0: &State<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    fun check_revoker<T0>(arg0: &State<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.revoker, 103);
    }

    fun check_version<T0>(arg0: &State<T0>) {
        assert!(arg0.version == 1, 100);
    }

    public fun create_coin<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: bool, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        let v3 = 0x2::tx_context::sender(arg8);
        let v4 = State<T0>{
            id             : 0x2::object::new(arg8),
            version        : 1,
            upgrade_cap_id : 0x1::option::none<0x2::object::ID>(),
            treasury_cap   : v0,
            deny_cap       : v1,
            owner          : v3,
            operator       : v3,
            revoker        : v3,
            delay          : arg7,
            mint_budget    : 0,
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T0>>(v2);
        0x2::transfer::public_share_object<State<T0>>(v4);
    }

    public fun delay<T0>(arg0: &State<T0>) : u64 {
        arg0.delay
    }

    entry fun execute_mint_to<T0>(arg0: &mut State<T0>, arg1: MintReq, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg3);
        let MintReq {
            id        : v0,
            recipient : v1,
            amount    : v2,
            et        : v3,
        } = arg1;
        check_effective_time(arg2, v3);
        assert!(arg0.mint_budget >= v2, 106);
        arg0.mint_budget = arg0.mint_budget - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, v2, arg3), v1);
        0x2::object::delete(v0);
        let v4 = MintEvent{
            to_address : v1,
            amount     : v2,
            et         : 0,
            req_id     : 0x2::object::id<MintReq>(&arg1),
        };
        0x2::event::emit<MintEvent>(v4);
    }

    entry fun execute_set_delay<T0>(arg0: &mut State<T0>, arg1: SetDelayReq, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        let SetDelayReq {
            id        : v0,
            new_delay : v1,
            et        : v2,
        } = arg1;
        check_effective_time(arg2, v2);
        arg0.delay = v1;
        0x2::object::delete(v0);
        let v3 = SetDelayEvent{
            old_delay : arg0.delay,
            new_delay : v1,
            et        : 0,
            req_id    : 0x2::object::id<SetDelayReq>(&arg1),
        };
        0x2::event::emit<SetDelayEvent>(v3);
    }

    entry fun execute_set_operator<T0>(arg0: &mut State<T0>, arg1: SetOperatorReq, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        let SetOperatorReq {
            id           : v0,
            new_operator : v1,
            et           : v2,
        } = arg1;
        check_effective_time(arg2, v2);
        arg0.operator = v1;
        0x2::object::delete(v0);
        let v3 = SetOperatorEvent{
            old_operator : arg0.operator,
            new_operator : v1,
            et           : 0,
            req_id       : 0x2::object::id<SetOperatorReq>(&arg1),
        };
        0x2::event::emit<SetOperatorEvent>(v3);
    }

    entry fun execute_set_revoker<T0>(arg0: &mut State<T0>, arg1: SetRevokerReq, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        let SetRevokerReq {
            id          : v0,
            new_revoker : v1,
            et          : v2,
        } = arg1;
        check_effective_time(arg2, v2);
        arg0.revoker = v1;
        0x2::object::delete(v0);
        let v3 = SetRevokerEvent{
            old_revoker : arg0.revoker,
            new_revoker : v1,
            et          : 0,
            req_id      : 0x2::object::id<SetRevokerReq>(&arg1),
        };
        0x2::event::emit<SetRevokerEvent>(v3);
    }

    entry fun execute_transfer_ownership<T0>(arg0: &mut State<T0>, arg1: TransferOwnershipReq, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.new_owner, 107);
        let TransferOwnershipReq {
            id          : v0,
            new_owner   : v1,
            upgrade_cap : v2,
            et          : v3,
        } = arg1;
        check_effective_time(arg2, v3);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(v2, v1);
        arg0.owner = v1;
        0x2::object::delete(v0);
        let v4 = TransferOwnershipEvent{
            old_owner : arg0.owner,
            new_owner : v1,
            et        : 0,
            req_id    : 0x2::object::id<TransferOwnershipReq>(&arg1),
        };
        0x2::event::emit<TransferOwnershipEvent>(v4);
    }

    fun get_effective_time<T0>(arg0: &State<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg1) / 1000 + arg0.delay
    }

    entry fun init_upgrade_cap_id<T0>(arg0: &mut State<T0>, arg1: &0x2::package::UpgradeCap, arg2: &0x2::tx_context::TxContext) {
        check_owner<T0>(arg0, arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.upgrade_cap_id), 110);
        let v0 = 0x2::package::upgrade_package(arg1);
        assert!(0x2::object::id_to_address(&v0) == package_address<T0>(arg0), 108);
        arg0.upgrade_cap_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg1));
    }

    entry fun migrate<T0>(arg0: &mut State<T0>, arg1: &0x2::tx_context::TxContext) {
        check_owner<T0>(arg0, arg1);
        assert!(arg0.version < 1, 100);
        arg0.version = 1;
    }

    public fun mint_budget<T0>(arg0: &State<T0>) : u64 {
        arg0.mint_budget
    }

    public fun operator<T0>(arg0: &State<T0>) : address {
        arg0.operator
    }

    public fun owner<T0>(arg0: &State<T0>) : address {
        arg0.owner
    }

    public fun package_address<T0>(arg0: &State<T0>) : address {
        let v0 = 0x1::type_name::get_with_original_ids<State<T0>>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    entry fun redeem<T0>(arg0: &mut State<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg2);
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
        arg0.mint_budget = arg0.mint_budget + v0;
        let v1 = RedeemEvent{
            from_address : 0x2::tx_context::sender(arg2),
            amount       : v0,
        };
        0x2::event::emit<RedeemEvent>(v1);
    }

    entry fun remove_from_blocked_list<T0>(arg0: &mut State<T0>, arg1: address, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg3);
        0x2::coin::deny_list_v2_remove<T0>(arg2, &mut arg0.deny_cap, arg1, arg3);
        let v0 = UnblockEvent{user_address: arg1};
        0x2::event::emit<UnblockEvent>(v0);
    }

    entry fun request_mint_to<T0>(arg0: &State<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg4);
        let v0 = get_effective_time<T0>(arg0, arg3);
        let v1 = MintReq{
            id        : 0x2::object::new(arg4),
            recipient : arg1,
            amount    : arg2,
            et        : v0,
        };
        0x2::transfer::share_object<MintReq>(v1);
        let v2 = MintEvent{
            to_address : arg1,
            amount     : arg2,
            et         : v0,
            req_id     : 0x2::object::id<MintReq>(&v1),
        };
        0x2::event::emit<MintEvent>(v2);
    }

    entry fun request_set_delay<T0>(arg0: &State<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        assert!(arg1 >= 3600, 105);
        let v0 = get_effective_time<T0>(arg0, arg2);
        let v1 = SetDelayReq{
            id        : 0x2::object::new(arg3),
            new_delay : arg1,
            et        : v0,
        };
        0x2::transfer::share_object<SetDelayReq>(v1);
        let v2 = SetDelayEvent{
            old_delay : arg0.delay,
            new_delay : arg1,
            et        : v0,
            req_id    : 0x2::object::id<SetDelayReq>(&v1),
        };
        0x2::event::emit<SetDelayEvent>(v2);
    }

    entry fun request_set_operator<T0>(arg0: &State<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        let v0 = get_effective_time<T0>(arg0, arg2);
        let v1 = SetOperatorReq{
            id           : 0x2::object::new(arg3),
            new_operator : arg1,
            et           : v0,
        };
        0x2::transfer::share_object<SetOperatorReq>(v1);
        let v2 = SetOperatorEvent{
            old_operator : arg0.operator,
            new_operator : arg1,
            et           : v0,
            req_id       : 0x2::object::id<SetOperatorReq>(&v1),
        };
        0x2::event::emit<SetOperatorEvent>(v2);
    }

    entry fun request_set_revoker<T0>(arg0: &State<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        let v0 = get_effective_time<T0>(arg0, arg2);
        let v1 = SetRevokerReq{
            id          : 0x2::object::new(arg3),
            new_revoker : arg1,
            et          : v0,
        };
        0x2::transfer::share_object<SetRevokerReq>(v1);
        let v2 = SetRevokerEvent{
            old_revoker : arg0.revoker,
            new_revoker : arg1,
            et          : v0,
            req_id      : 0x2::object::id<SetRevokerReq>(&v1),
        };
        0x2::event::emit<SetRevokerEvent>(v2);
    }

    entry fun request_transfer_ownership<T0>(arg0: &State<T0>, arg1: address, arg2: 0x2::package::UpgradeCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg4);
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(&arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.upgrade_cap_id, &v0), 108);
        let v1 = get_effective_time<T0>(arg0, arg3);
        let v2 = TransferOwnershipReq{
            id          : 0x2::object::new(arg4),
            new_owner   : arg1,
            upgrade_cap : arg2,
            et          : v1,
        };
        let v3 = TransferOwnershipEvent{
            old_owner : arg0.owner,
            new_owner : arg1,
            et        : v1,
            req_id    : 0x2::object::id<TransferOwnershipReq>(&v2),
        };
        0x2::event::emit<TransferOwnershipEvent>(v3);
        0x2::transfer::share_object<TransferOwnershipReq>(v2);
    }

    entry fun revoke_mint_to<T0>(arg0: &State<T0>, arg1: MintReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_revoker<T0>(arg0, arg2);
        let MintReq {
            id        : v0,
            recipient : _,
            amount    : _,
            et        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    entry fun revoke_set_delay<T0>(arg0: &State<T0>, arg1: SetDelayReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_revoker<T0>(arg0, arg2);
        let SetDelayReq {
            id        : v0,
            new_delay : _,
            et        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    entry fun revoke_set_operator<T0>(arg0: &State<T0>, arg1: SetOperatorReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_revoker<T0>(arg0, arg2);
        let SetOperatorReq {
            id           : v0,
            new_operator : _,
            et           : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    entry fun revoke_set_revoker<T0>(arg0: &State<T0>, arg1: SetRevokerReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg2);
        let SetRevokerReq {
            id          : v0,
            new_revoker : _,
            et          : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    entry fun revoke_transfer_ownership<T0>(arg0: &State<T0>, arg1: TransferOwnershipReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg2);
        let TransferOwnershipReq {
            id          : v0,
            new_owner   : _,
            upgrade_cap : v2,
            et          : _,
        } = arg1;
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(v2, arg0.owner);
        0x2::object::delete(v0);
    }

    public fun revoker<T0>(arg0: &State<T0>) : address {
        arg0.revoker
    }

    public fun upgrade_cap_id<T0>(arg0: &State<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.upgrade_cap_id
    }

    public fun version<T0>(arg0: &State<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

