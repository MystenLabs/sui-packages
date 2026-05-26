module 0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::auto_swap {
    struct AutoSwapRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_validations: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AutoSwapCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        owner: address,
        max_per_swap: u64,
        expires_at_ms: u64,
        paused: bool,
    }

    struct AutoSwapEnabled has copy, drop {
        owner: address,
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        coin_type: vector<u8>,
        max_per_swap: u64,
        expires_at_ms: u64,
    }

    struct AutoSwapDisabled has copy, drop {
        owner: address,
        cap_id: 0x2::object::ID,
        coin_type: vector<u8>,
    }

    struct AutoSwapPaused has copy, drop {
        owner: address,
        cap_id: 0x2::object::ID,
        paused: bool,
    }

    struct AutoSwapValidated has copy, drop {
        admin: address,
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        amount: u64,
        coin_type: vector<u8>,
    }

    public fun admin(arg0: &AutoSwapRegistry) : address {
        arg0.admin
    }

    public fun cap_expiry<T0>(arg0: &AutoSwapCap<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun cap_max<T0>(arg0: &AutoSwapCap<T0>) : u64 {
        arg0.max_per_swap
    }

    public fun cap_owner<T0>(arg0: &AutoSwapCap<T0>) : address {
        arg0.owner
    }

    public fun cap_paused<T0>(arg0: &AutoSwapCap<T0>) : bool {
        arg0.paused
    }

    public fun cap_vault<T0>(arg0: &AutoSwapCap<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public entry fun disable<T0>(arg0: AutoSwapCap<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 106);
        let AutoSwapCap {
            id            : v0,
            vault_id      : _,
            owner         : v2,
            max_per_swap  : _,
            expires_at_ms : _,
            paused        : _,
        } = arg0;
        let v6 = v0;
        let v7 = AutoSwapDisabled{
            owner     : v2,
            cap_id    : 0x2::object::uid_to_inner(&v6),
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
        };
        0x2::event::emit<AutoSwapDisabled>(v7);
        0x2::object::delete(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AutoSwapRegistry{
            id                : 0x2::object::new(arg0),
            admin             : 0x2::tx_context::sender(arg0),
            total_validations : 0,
        };
        0x2::transfer::share_object<AutoSwapRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun mint_cap<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : AutoSwapCap<T0> {
        assert!(arg2 > 0, 104);
        let v0 = AutoSwapCap<T0>{
            id            : 0x2::object::new(arg4),
            vault_id      : arg0,
            owner         : arg1,
            max_per_swap  : arg2,
            expires_at_ms : arg3,
            paused        : false,
        };
        let v1 = AutoSwapEnabled{
            owner         : arg1,
            vault_id      : arg0,
            cap_id        : 0x2::object::id<AutoSwapCap<T0>>(&v0),
            coin_type     : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            max_per_swap  : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<AutoSwapEnabled>(v1);
        v0
    }

    public entry fun pause<T0>(arg0: &mut AutoSwapCap<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 106);
        arg0.paused = true;
        let v0 = AutoSwapPaused{
            owner  : arg0.owner,
            cap_id : 0x2::object::id<AutoSwapCap<T0>>(arg0),
            paused : true,
        };
        0x2::event::emit<AutoSwapPaused>(v0);
    }

    public entry fun resume<T0>(arg0: &mut AutoSwapCap<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 106);
        arg0.paused = false;
        let v0 = AutoSwapPaused{
            owner  : arg0.owner,
            cap_id : 0x2::object::id<AutoSwapCap<T0>>(arg0),
            paused : false,
        };
        0x2::event::emit<AutoSwapPaused>(v0);
    }

    public fun total_validations(arg0: &AutoSwapRegistry) : u64 {
        arg0.total_validations
    }

    public entry fun update_bounds<T0>(arg0: &mut AutoSwapCap<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 106);
        assert!(arg1 > 0, 104);
        arg0.max_per_swap = arg1;
        arg0.expires_at_ms = arg2;
    }

    public(friend) fun validate_for_swap<T0>(arg0: &mut AutoSwapRegistry, arg1: &AutoSwapCap<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.admin, 103);
        assert!(!arg1.paused, 100);
        if (arg1.expires_at_ms != 0) {
            assert!(arg3 <= arg1.expires_at_ms, 101);
        };
        assert!(arg2 <= arg1.max_per_swap, 102);
        arg0.total_validations = arg0.total_validations + 1;
        let v1 = AutoSwapValidated{
            admin     : v0,
            vault_id  : arg1.vault_id,
            cap_id    : 0x2::object::id<AutoSwapCap<T0>>(arg1),
            amount    : arg2,
            coin_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
        };
        0x2::event::emit<AutoSwapValidated>(v1);
    }

    // decompiled from Move bytecode v7
}

