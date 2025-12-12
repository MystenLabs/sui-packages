module 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::curator_position {
    struct CuratorConfigUpgraded has copy, drop {
        curator_config_id: address,
        version: u64,
    }

    struct CuratorCapCreated has copy, drop {
        curator_cap_id: address,
        curator: address,
    }

    struct CuratorCapInfoTransferred has copy, drop {
        curator_cap_id: address,
        old_curator: address,
        new_curator: address,
    }

    struct CuratorPositionCreated has copy, drop {
        curator_position_id: address,
        curator_cap_id: address,
        init_curator: address,
    }

    struct CuratorCapAdded has copy, drop {
        curator_cap_id: address,
    }

    struct CuratorCapRemoved has copy, drop {
        curator_cap_id: address,
    }

    struct CuratorCapPairedWithPosition has copy, drop {
        curator_cap_id: address,
        curator_position_id: address,
    }

    struct CuratorCapRemovedFromPosition has copy, drop {
        curator_cap_id: address,
        curator_position_id: address,
    }

    struct CuratorPositionValueSubmitted has copy, drop {
        curator_position_id: address,
        curator_cap_id: address,
        position_value: u256,
        timestamp_ms: u64,
        valid_time: u64,
    }

    struct CuratorPositionValueApproved has copy, drop {
        curator_position_id: address,
        position_value: u256,
    }

    struct CuratorPositionValueDenied has copy, drop {
        curator_position_id: address,
        position_value: u256,
    }

    struct CuratorPositionLoopedIn has copy, drop {
        curator_position_id: address,
        curator_cap_id: address,
        curator: address,
        principal_coin_type: 0x1::type_name::TypeName,
        principal_amount: u64,
        total_usd_value: u256,
        total_shares: u256,
    }

    struct CuratorPositionLoopedOut has copy, drop {
        curator_position_id: address,
        curator_cap_id: address,
        curator: address,
        principal_coin_type: 0x1::type_name::TypeName,
        principal_amount: u64,
        total_usd_value: u256,
        total_shares: u256,
    }

    struct CuratorPositionValueUpdated has copy, drop {
        curator_position_id: address,
        position_value: u256,
        timestamp_ms: u64,
    }

    struct CuratorCap has store, key {
        id: 0x2::object::UID,
        curator: address,
    }

    struct CuratorPosition has store, key {
        id: 0x2::object::UID,
    }

    struct CuratorConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        valid_curator_caps: 0x2::table::Table<address, bool>,
        curator_position_pairs: 0x2::table::Table<address, address>,
        curator_cap_to_curator: 0x2::table::Table<address, address>,
        curator_position_values: 0x2::table::Table<address, CuratorPositionValue>,
        curator_position_to_vault: 0x2::table::Table<address, address>,
        curator_position_to_curator_caps: 0x2::table::Table<address, vector<address>>,
    }

    struct CuratorPositionValue has copy, drop, store {
        position_value: u256,
        position_value_updated: u64,
        position_value_valid_time: u64,
        valid: bool,
    }

    public fun assert_valid_curator_cap(arg0: &CuratorConfig, arg1: address, arg2: address) {
        check_version(arg0);
        assert!(0x2::table::contains<address, bool>(&arg0.valid_curator_caps, arg2), 8001);
        assert!(0x2::table::contains<address, address>(&arg0.curator_position_pairs, arg2), 8003);
        assert!(0x2::table::borrow<address, address>(&arg0.curator_position_pairs, arg2) == &arg1, 8004);
    }

    public fun assert_valid_curator_position_value(arg0: &CuratorConfig, arg1: address, arg2: u64) {
        check_version(arg0);
        let v0 = 0x2::table::borrow<address, CuratorPositionValue>(&arg0.curator_position_values, arg1);
        assert!(v0.valid, 8006);
        let v1 = 0x1::ascii::string(b"111");
        0x1::debug::print<0x1::ascii::String>(&v1);
        0x1::debug::print<u64>(&arg2);
        0x1::debug::print<u64>(&v0.position_value_updated);
        0x1::debug::print<u64>(&v0.position_value_valid_time);
        assert!(v0.position_value_updated + v0.position_value_valid_time >= arg2, 8007);
    }

    public(friend) fun check_version(arg0: &CuratorConfig) {
        assert!(arg0.version == 1, 8008);
    }

    public fun create_curator_cap(arg0: &mut CuratorConfig, arg1: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : CuratorCap {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = CuratorCap{
            id      : v0,
            curator : arg2,
        };
        0x2::table::add<address, address>(&mut arg0.curator_cap_to_curator, v1, arg2);
        let v3 = CuratorCapCreated{
            curator_cap_id : v1,
            curator        : arg2,
        };
        0x2::event::emit<CuratorCapCreated>(v3);
        v2
    }

    public fun create_curator_position(arg0: &mut CuratorConfig, arg1: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::AdminCap, arg2: CuratorCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : CuratorPosition {
        check_version(arg0);
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = curator_cap_id(&arg2);
        let v3 = curator_cap_curator_address(&arg2);
        let v4 = CuratorPosition{id: v0};
        0x2::table::add<address, address>(&mut arg0.curator_position_to_vault, v1, arg3);
        0x2::table::add<address, vector<address>>(&mut arg0.curator_position_to_curator_caps, v1, 0x1::vector::singleton<address>(v2));
        let v5 = CuratorPositionValue{
            position_value            : 0,
            position_value_updated    : 0,
            position_value_valid_time : 0,
            valid                     : false,
        };
        0x2::table::add<address, CuratorPositionValue>(&mut arg0.curator_position_values, v1, v5);
        set_curator_cap_paired_with_position(arg0, v1, v2);
        0x2::transfer::public_transfer<CuratorCap>(arg2, v3);
        let v6 = CuratorPositionCreated{
            curator_position_id : v1,
            curator_cap_id      : v2,
            init_curator        : v3,
        };
        0x2::event::emit<CuratorPositionCreated>(v6);
        v4
    }

    public fun create_curator_position_with_auto_transfer(arg0: &mut CuratorConfig, arg1: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::AdminCap, arg2: CuratorCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = curator_cap_to_curator(arg0, curator_cap_id(&arg2));
        0x2::transfer::public_transfer<CuratorPosition>(create_curator_position(arg0, arg1, arg2, arg3, arg4), v0);
    }

    public fun curator_cap_curator_address(arg0: &CuratorCap) : address {
        arg0.curator
    }

    public fun curator_cap_id(arg0: &CuratorCap) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun curator_cap_paired_position(arg0: &CuratorConfig, arg1: address) : address {
        *0x2::table::borrow<address, address>(&arg0.curator_position_pairs, arg1)
    }

    public fun curator_cap_to_curator(arg0: &CuratorConfig, arg1: address) : address {
        *0x2::table::borrow<address, address>(&arg0.curator_cap_to_curator, arg1)
    }

    public(friend) fun init_curator_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CuratorConfig{
            id                               : 0x2::object::new(arg0),
            version                          : 1,
            valid_curator_caps               : 0x2::table::new<address, bool>(arg0),
            curator_position_pairs           : 0x2::table::new<address, address>(arg0),
            curator_cap_to_curator           : 0x2::table::new<address, address>(arg0),
            curator_position_values          : 0x2::table::new<address, CuratorPositionValue>(arg0),
            curator_position_to_vault        : 0x2::table::new<address, address>(arg0),
            curator_position_to_curator_caps : 0x2::table::new<address, vector<address>>(arg0),
        };
        0x2::transfer::share_object<CuratorConfig>(v0);
    }

    public fun is_valid_curator_cap(arg0: &CuratorConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.valid_curator_caps, arg1)
    }

    public fun loop_in_curator_position<T0>(arg0: &mut CuratorConfig, arg1: &mut 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Vault<T0>, arg2: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Operation, arg3: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::OperatorCap, arg4: address, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::assert_operator_not_freezed(arg2, arg3);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::assert_single_vault_operator_paired(arg2, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::vault_id<T0>(arg1), arg3);
        let v0 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::parse_key<CuratorPosition>(arg5);
        let v1 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::borrow_defi_asset<T0, CuratorPosition>(arg1, v0);
        let v2 = 0x2::object::uid_to_address(&v1.id);
        assert_valid_curator_cap(arg0, v2, arg4);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::return_defi_asset<T0, CuratorPosition>(arg1, v0, v1);
        let v3 = if (arg6 > 0) {
            0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::borrow_free_principal<T0>(arg1, arg6)
        } else {
            0x2::balance::zero<T0>()
        };
        let v4 = curator_cap_to_curator(arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg8), v4);
        let v5 = CuratorPositionLoopedIn{
            curator_position_id : v2,
            curator_cap_id      : arg4,
            curator             : v4,
            principal_coin_type : 0x1::type_name::with_defining_ids<T0>(),
            principal_amount    : arg6,
            total_usd_value     : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::get_total_usd_value<T0>(arg1, arg7),
            total_shares        : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::total_shares<T0>(arg1),
        };
        0x2::event::emit<CuratorPositionLoopedIn>(v5);
    }

    public fun loop_out_curator_position<T0>(arg0: &mut CuratorConfig, arg1: &mut 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Vault<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &CuratorCap, arg5: &0x2::clock::Clock) {
        check_version(arg0);
        loop_out_curator_position_internal<T0>(arg0, arg1, arg2, curator_cap_id(arg4), arg3, arg5);
    }

    public fun loop_out_curator_position_by_operator<T0>(arg0: &mut CuratorConfig, arg1: &mut 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Vault<T0>, arg2: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Operation, arg3: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::OperatorCap, arg4: u8, arg5: address, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock) {
        check_version(arg0);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::assert_operator_not_freezed(arg2, arg3);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::assert_single_vault_operator_paired(arg2, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::vault_id<T0>(arg1), arg3);
        loop_out_curator_position_internal<T0>(arg0, arg1, arg4, arg5, arg6, arg7);
    }

    public fun loop_out_curator_position_internal<T0>(arg0: &mut CuratorConfig, arg1: &mut 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Vault<T0>, arg2: u8, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock) {
        let v0 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::parse_key<CuratorPosition>(arg2);
        let v1 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::borrow_defi_asset<T0, CuratorPosition>(arg1, v0);
        let v2 = 0x2::object::uid_to_address(&v1.id);
        assert_valid_curator_cap(arg0, v2, arg3);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::return_defi_asset<T0, CuratorPosition>(arg1, v0, v1);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::return_free_principal<T0>(arg1, 0x2::coin::into_balance<T0>(arg4));
        let v3 = CuratorPositionLoopedOut{
            curator_position_id : v2,
            curator_cap_id      : arg3,
            curator             : curator_cap_to_curator(arg0, arg3),
            principal_coin_type : 0x1::type_name::with_defining_ids<T0>(),
            principal_amount    : 0x2::coin::value<T0>(&arg4),
            total_usd_value     : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::get_total_usd_value<T0>(arg1, arg5),
            total_shares        : 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::total_shares<T0>(arg1),
        };
        0x2::event::emit<CuratorPositionLoopedOut>(v3);
    }

    public fun position_id(arg0: &CuratorPosition) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun position_value(arg0: &CuratorConfig, arg1: address) : u256 {
        0x2::table::borrow<address, CuratorPositionValue>(&arg0.curator_position_values, arg1).position_value
    }

    public fun position_value_info(arg0: &CuratorConfig, arg1: address) : CuratorPositionValue {
        *0x2::table::borrow<address, CuratorPositionValue>(&arg0.curator_position_values, arg1)
    }

    public fun position_value_updated(arg0: &CuratorConfig, arg1: address) : u64 {
        0x2::table::borrow<address, CuratorPositionValue>(&arg0.curator_position_values, arg1).position_value_updated
    }

    public fun position_value_valid_time(arg0: &CuratorConfig, arg1: address) : u64 {
        0x2::table::borrow<address, CuratorPositionValue>(&arg0.curator_position_values, arg1).position_value_valid_time
    }

    public(friend) fun remove_curator_cap_paired_with_position(arg0: &mut CuratorConfig, arg1: address, arg2: address) {
        check_version(arg0);
        let v0 = &mut arg0.curator_position_pairs;
        assert!(0x2::table::contains<address, address>(v0, arg2), 8003);
        assert!(*0x2::table::borrow<address, address>(v0, arg2) == arg1, 8004);
        0x2::table::remove<address, address>(v0, arg2);
        let v1 = CuratorCapRemovedFromPosition{
            curator_cap_id      : arg2,
            curator_position_id : arg1,
        };
        0x2::event::emit<CuratorCapRemovedFromPosition>(v1);
    }

    public(friend) fun set_curator_cap_paired_with_position(arg0: &mut CuratorConfig, arg1: address, arg2: address) {
        check_version(arg0);
        let v0 = &mut arg0.curator_position_pairs;
        let v1 = &mut arg0.curator_position_to_curator_caps;
        assert!(!0x2::table::contains<address, address>(v0, arg2), 8005);
        0x2::table::add<address, address>(v0, arg2, arg1);
        if (!0x2::table::contains<address, vector<address>>(v1, arg1)) {
            0x2::table::add<address, vector<address>>(v1, arg1, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(v1, arg1), arg2);
        let v2 = CuratorCapPairedWithPosition{
            curator_cap_id      : arg2,
            curator_position_id : arg1,
        };
        0x2::event::emit<CuratorCapPairedWithPosition>(v2);
    }

    public(friend) fun upgrade_curator_config(arg0: &mut CuratorConfig) {
        check_version(arg0);
        assert!(arg0.version < 1, 8008);
        arg0.version = 1;
        let v0 = CuratorConfigUpgraded{
            curator_config_id : 0x2::object::uid_to_address(&arg0.id),
            version           : 1,
        };
        0x2::event::emit<CuratorConfigUpgraded>(v0);
    }

    // decompiled from Move bytecode v6
}

