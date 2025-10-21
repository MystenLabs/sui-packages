module 0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::deusd {
    struct DEUSD has drop {
        dummy_field: bool,
    }

    struct DeUSDTreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeUSDConfig has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<DEUSD>,
        deny_cap: 0x2::coin::DenyCapV2<DEUSD>,
    }

    struct DeUSDTreasuryCapConfig has key {
        id: 0x2::object::UID,
        is_active_deusd_treasury_cap: 0x2::linked_table::LinkedTable<0x2::object::ID, bool>,
    }

    struct DeUSDTreasuryCapView has copy, drop, store {
        id: 0x2::object::ID,
        is_active: bool,
    }

    struct Mint has copy, drop, store {
        to: address,
        amount: u64,
    }

    struct Burn has copy, drop, store {
        from: address,
        amount: u64,
    }

    struct DeUSDTreasuryCapCreated has copy, drop {
        to: address,
    }

    struct DeUSDTreasuryCapStatusChanged has copy, drop {
        cap_id: 0x2::object::ID,
        is_active: bool,
    }

    struct DeUSDConfigDeleted has copy, drop {
        caps_owner: address,
    }

    struct DeUSDTreasuryCapConfigInitialized has copy, drop {
        dummy_field: bool,
    }

    struct DeUSDConfigInitialized has copy, drop {
        dummy_field: bool,
    }

    public(friend) fun mint(arg0: &mut DeUSDConfig, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 1);
        assert!(arg2 > 0, 2);
        let v0 = Mint{
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<Mint>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEUSD>>(0x2::coin::mint<DEUSD>(&mut arg0.treasury_cap, arg2, arg3), arg1);
    }

    public fun total_supply(arg0: &DeUSDConfig) : u64 {
        0x2::coin::total_supply<DEUSD>(&arg0.treasury_cap)
    }

    fun assert_is_active_deusd_treasury_cap(arg0: &DeUSDTreasuryCapConfig, arg1: &DeUSDTreasuryCap) {
        assert!(*0x2::linked_table::borrow<0x2::object::ID, bool>(&arg0.is_active_deusd_treasury_cap, 0x2::object::id<DeUSDTreasuryCap>(arg1)), 4);
    }

    public(friend) fun burn_from(arg0: &mut DeUSDConfig, arg1: 0x2::coin::Coin<DEUSD>, arg2: address) {
        let v0 = Burn{
            from   : arg2,
            amount : 0x2::coin::value<DEUSD>(&arg1),
        };
        0x2::event::emit<Burn>(v0);
        0x2::coin::burn<DEUSD>(&mut arg0.treasury_cap, arg1);
    }

    public fun burn_with_cap(arg0: &DeUSDTreasuryCap, arg1: &mut DeUSDConfig, arg2: &DeUSDTreasuryCapConfig, arg3: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg4: 0x2::coin::Coin<DEUSD>, arg5: address) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg3);
        assert_is_active_deusd_treasury_cap(arg2, arg0);
        let v0 = Burn{
            from   : arg5,
            amount : 0x2::coin::value<DEUSD>(&arg4),
        };
        0x2::event::emit<Burn>(v0);
        0x2::coin::burn<DEUSD>(&mut arg1.treasury_cap, arg4);
    }

    public fun create_treasury_cap(arg0: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::admin_cap::AdminCap, arg1: &mut DeUSDTreasuryCapConfig, arg2: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg2);
        assert!(arg3 != @0x0, 1);
        let v0 = DeUSDTreasuryCap{id: 0x2::object::new(arg4)};
        0x2::linked_table::push_back<0x2::object::ID, bool>(&mut arg1.is_active_deusd_treasury_cap, 0x2::object::id<DeUSDTreasuryCap>(&v0), true);
        0x2::transfer::transfer<DeUSDTreasuryCap>(v0, arg3);
        let v1 = DeUSDTreasuryCapCreated{to: arg3};
        0x2::event::emit<DeUSDTreasuryCapCreated>(v1);
    }

    public fun decimals() : u8 {
        6
    }

    public fun delete_deusd_config(arg0: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::admin_cap::AdminCap, arg1: DeUSDConfig, arg2: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg3: address) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg2);
        assert!(arg3 != @0x0, 1);
        let DeUSDConfig {
            id           : v0,
            treasury_cap : v1,
            deny_cap     : v2,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEUSD>>(v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DEUSD>>(v2, arg3);
        let v3 = DeUSDConfigDeleted{caps_owner: arg3};
        0x2::event::emit<DeUSDConfigDeleted>(v3);
    }

    public fun get_treasury_caps(arg0: &DeUSDTreasuryCapConfig) : vector<DeUSDTreasuryCapView> {
        let v0 = 0x1::vector::empty<DeUSDTreasuryCapView>();
        let v1 = 0x2::linked_table::front<0x2::object::ID, bool>(&arg0.is_active_deusd_treasury_cap);
        while (0x1::option::is_some<0x2::object::ID>(v1)) {
            let v2 = *0x1::option::borrow<0x2::object::ID>(v1);
            let v3 = DeUSDTreasuryCapView{
                id        : v2,
                is_active : *0x2::linked_table::borrow<0x2::object::ID, bool>(&arg0.is_active_deusd_treasury_cap, v2),
            };
            0x1::vector::push_back<DeUSDTreasuryCapView>(&mut v0, v3);
            v1 = 0x2::linked_table::next<0x2::object::ID, bool>(&arg0.is_active_deusd_treasury_cap, v2);
        };
        v0
    }

    fun init(arg0: DEUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DEUSD>(arg0, 6, b"deUSD", b"Elixir's deUSD", b"Elixir's deUSD", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEUSD>>(v2);
        let v3 = DeUSDConfig{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            deny_cap     : v1,
        };
        0x2::transfer::share_object<DeUSDConfig>(v3);
    }

    public fun initialize_deusd_config(arg0: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg1: 0x2::coin::TreasuryCap<DEUSD>, arg2: 0x2::coin::DenyCapV2<DEUSD>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg0);
        let v0 = DeUSDConfig{
            id           : 0x2::object::new(arg3),
            treasury_cap : arg1,
            deny_cap     : arg2,
        };
        0x2::transfer::share_object<DeUSDConfig>(v0);
        let v1 = DeUSDConfigInitialized{dummy_field: false};
        0x2::event::emit<DeUSDConfigInitialized>(v1);
    }

    public fun initialize_deusd_treasury_cap_config(arg0: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::admin_cap::AdminCap, arg1: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg1);
        let v0 = DeUSDTreasuryCapConfig{
            id                           : 0x2::object::new(arg2),
            is_active_deusd_treasury_cap : 0x2::linked_table::new<0x2::object::ID, bool>(arg2),
        };
        0x2::transfer::share_object<DeUSDTreasuryCapConfig>(v0);
        let v1 = DeUSDTreasuryCapConfigInitialized{dummy_field: false};
        0x2::event::emit<DeUSDTreasuryCapConfigInitialized>(v1);
    }

    public fun is_active_deusd_treasury_cap(arg0: &DeUSDTreasuryCapConfig, arg1: 0x2::object::ID) : bool {
        *0x2::linked_table::borrow<0x2::object::ID, bool>(&arg0.is_active_deusd_treasury_cap, arg1)
    }

    public fun mint_with_cap(arg0: &DeUSDTreasuryCap, arg1: &mut DeUSDConfig, arg2: &DeUSDTreasuryCapConfig, arg3: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg3);
        assert_is_active_deusd_treasury_cap(arg2, arg0);
        assert!(arg4 != @0x0, 1);
        assert!(arg5 > 0, 2);
        let v0 = Mint{
            to     : arg4,
            amount : arg5,
        };
        0x2::event::emit<Mint>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEUSD>>(0x2::coin::mint<DEUSD>(&mut arg1.treasury_cap, arg5, arg6), arg4);
    }

    public fun set_treasury_cap_status(arg0: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::admin_cap::AdminCap, arg1: &mut DeUSDTreasuryCapConfig, arg2: &0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::GlobalConfig, arg3: 0x2::object::ID, arg4: bool) {
        0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::config::check_package_version(arg2);
        assert!(0x2::linked_table::contains<0x2::object::ID, bool>(&arg1.is_active_deusd_treasury_cap, arg3), 3);
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, bool>(&mut arg1.is_active_deusd_treasury_cap, arg3);
        if (*v0 != arg4) {
            *v0 = arg4;
            let v1 = DeUSDTreasuryCapStatusChanged{
                cap_id    : arg3,
                is_active : arg4,
            };
            0x2::event::emit<DeUSDTreasuryCapStatusChanged>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

