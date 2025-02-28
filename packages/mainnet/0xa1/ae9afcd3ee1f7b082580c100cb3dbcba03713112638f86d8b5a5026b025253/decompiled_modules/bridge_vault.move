module 0xa1ae9afcd3ee1f7b082580c100cb3dbcba03713112638f86d8b5a5026b025253::bridge_vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        is_paused: bool,
        roles: 0x2::bag::Bag,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauserCap has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct WithdrawEvent<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        address: address,
    }

    struct DepositEvent<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        address: address,
    }

    struct CapabilityAssignedEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        owner: address,
    }

    struct CapabilityRemovedEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        owner: address,
    }

    struct BridgeWitness has drop {
        dummy_field: bool,
    }

    fun add_cap<T0, T1, T2: drop + store>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: T2) {
        let v0 = RoleKey<T2>{owner: arg1};
        0x2::bag::add<RoleKey<T2>, T2>(&mut arg0.roles, v0, arg2);
    }

    public fun add_capability<T0, T1, T2: drop + store>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: address, arg3: T2) {
        assert!(!has_cap<T0, T1, T2>(arg1, arg2), 3);
        let v0 = CapabilityAssignedEvent<T0, T1, T2>{owner: arg2};
        0x2::event::emit<CapabilityAssignedEvent<T0, T1, T2>>(v0);
        add_cap<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun claim_native<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Vault<T0, T1>, arg2: &mut 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::treasury::ControlledTreasury<T1>, arg3: &0x2::deny_list::DenyList, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg0);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg0));
        let v1 = BridgeWitness{dummy_field: false};
        0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::treasury::mint_with_witness<T1, BridgeWitness>(v1, arg2, v0, 0x2::tx_context::sender(arg4), arg3, arg4);
        let v2 = WithdrawEvent<T0, T1>{
            amount  : v0,
            address : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<WithdrawEvent<T0, T1>>(v2);
    }

    public fun disable_pause<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, T1, PauserCap>(arg0, 0x2::tx_context::sender(arg1)), 2);
        arg0.is_paused = false;
    }

    public fun enable_pause<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<T0, T1, PauserCap>(arg0, 0x2::tx_context::sender(arg1)), 2);
        arg0.is_paused = true;
    }

    public fun has_cap<T0, T1, T2: store>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        let v0 = RoleKey<T2>{owner: arg1};
        0x2::bag::contains<RoleKey<T2>>(&arg0.roles, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused_enabled<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.is_paused
    }

    public fun new_pauser_cap() : PauserCap {
        PauserCap{dummy_field: false}
    }

    public fun new_vault<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0, T1>{
            id        : 0x2::object::new(arg1),
            balance   : 0x2::balance::zero<T0>(),
            is_paused : false,
            roles     : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
    }

    fun remove_cap<T0, T1, T2: drop + store>(arg0: &mut Vault<T0, T1>, arg1: address) : T2 {
        let v0 = RoleKey<T2>{owner: arg1};
        0x2::bag::remove<RoleKey<T2>, T2>(&mut arg0.roles, v0)
    }

    public fun remove_capability<T0, T1, T2: drop + store>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: address) {
        assert!(has_cap<T0, T1, T2>(arg1, arg2), 2);
        let v0 = CapabilityRemovedEvent<T0, T1, T2>{owner: arg2};
        0x2::event::emit<CapabilityRemovedEvent<T0, T1, T2>>(v0);
        remove_cap<T0, T1, T2>(arg1, arg2);
    }

    public fun return_native<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Vault<T1, T0>, arg2: &mut 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::treasury::ControlledTreasury<T0>, arg3: &mut 0xb::bridge::Bridge, arg4: u8, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 4);
        assert!(0x2::balance::value<T1>(&arg1.balance) >= v0, 0);
        0xb::bridge::send_token<T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance, v0), arg6), arg6);
        0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::treasury::burn<T0>(arg2, arg0, arg6);
        let v1 = DepositEvent<T1, T0>{
            amount  : v0,
            address : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<DepositEvent<T1, T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

