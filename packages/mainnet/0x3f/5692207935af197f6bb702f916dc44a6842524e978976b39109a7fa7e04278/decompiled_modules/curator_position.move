module 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::curator_position {
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

    public(friend) fun add_curator_cap(arg0: &mut CuratorConfig, arg1: address) {
        check_version(arg0);
        let v0 = &mut arg0.valid_curator_caps;
        assert!(!0x2::table::contains<address, bool>(v0, arg1), 8002);
        0x2::table::add<address, bool>(v0, arg1, true);
        let v1 = CuratorCapAdded{curator_cap_id: arg1};
        0x2::event::emit<CuratorCapAdded>(v1);
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

    public fun create_curator_cap(arg0: &mut CuratorConfig, arg1: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : CuratorCap {
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

    public fun create_curator_position(arg0: &mut CuratorConfig, arg1: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::AdminCap, arg2: CuratorCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : CuratorPosition {
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

    public fun create_curator_position_with_auto_transfer(arg0: &mut CuratorConfig, arg1: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::AdminCap, arg2: CuratorCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
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

    public fun loop_in_curator_position<T0>(arg0: &mut CuratorConfig, arg1: &mut 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::Vault<T0>, arg2: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::Operation, arg3: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::OperatorCap, arg4: address, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::assert_operator_not_freezed(arg2, arg3);
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::assert_single_vault_operator_paired(arg2, 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::vault_id<T0>(arg1), arg3);
        let v0 = 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault_utils::parse_key<CuratorPosition>(arg5);
        let v1 = 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::borrow_defi_asset<T0, CuratorPosition>(arg1, v0);
        let v2 = 0x2::object::uid_to_address(&v1.id);
        assert_valid_curator_cap(arg0, v2, arg4);
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::return_defi_asset<T0, CuratorPosition>(arg1, v0, v1);
        let v3 = if (arg6 > 0) {
            0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::borrow_free_principal<T0>(arg1, arg6)
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
            total_usd_value     : 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::get_total_usd_value<T0>(arg1, arg7),
            total_shares        : 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::total_shares<T0>(arg1),
        };
        0x2::event::emit<CuratorPositionLoopedIn>(v5);
    }

    public fun loop_out_curator_position<T0>(arg0: &mut CuratorConfig, arg1: &mut 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::Vault<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &CuratorCap, arg5: &0x2::clock::Clock) {
        check_version(arg0);
        loop_out_curator_position_internal<T0>(arg0, arg1, arg2, curator_cap_id(arg4), arg3, arg5);
    }

    public fun loop_out_curator_position_by_operator<T0>(arg0: &mut CuratorConfig, arg1: &mut 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::Vault<T0>, arg2: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::Operation, arg3: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::OperatorCap, arg4: u8, arg5: address, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock) {
        check_version(arg0);
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::assert_operator_not_freezed(arg2, arg3);
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::assert_single_vault_operator_paired(arg2, 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::vault_id<T0>(arg1), arg3);
        loop_out_curator_position_internal<T0>(arg0, arg1, arg4, arg5, arg6, arg7);
    }

    public fun loop_out_curator_position_internal<T0>(arg0: &mut CuratorConfig, arg1: &mut 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::Vault<T0>, arg2: u8, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock) {
        let v0 = 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault_utils::parse_key<CuratorPosition>(arg2);
        let v1 = 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::borrow_defi_asset<T0, CuratorPosition>(arg1, v0);
        let v2 = 0x2::object::uid_to_address(&v1.id);
        assert_valid_curator_cap(arg0, v2, arg3);
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::return_defi_asset<T0, CuratorPosition>(arg1, v0, v1);
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::return_free_principal<T0>(arg1, 0x2::coin::into_balance<T0>(arg4));
        let v3 = CuratorPositionLoopedOut{
            curator_position_id : v2,
            curator_cap_id      : arg3,
            curator             : curator_cap_to_curator(arg0, arg3),
            principal_coin_type : 0x1::type_name::with_defining_ids<T0>(),
            principal_amount    : 0x2::coin::value<T0>(&arg4),
            total_usd_value     : 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::get_total_usd_value<T0>(arg1, arg5),
            total_shares        : 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::total_shares<T0>(arg1),
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

    public(friend) fun remove_curator_cap(arg0: &mut CuratorConfig, arg1: address) {
        check_version(arg0);
        let v0 = &mut arg0.valid_curator_caps;
        assert!(0x2::table::contains<address, bool>(v0, arg1), 8001);
        0x2::table::remove<address, bool>(v0, arg1);
        let v1 = curator_cap_paired_position(arg0, arg1);
        remove_curator_cap_paired_with_position(arg0, v1, arg1);
        let v2 = CuratorCapRemoved{curator_cap_id: arg1};
        0x2::event::emit<CuratorCapRemoved>(v2);
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

    public fun submit_curator_position_value(arg0: &mut CuratorConfig, arg1: &CuratorCap, arg2: address, arg3: u256, arg4: u64, arg5: &0x2::clock::Clock) {
        check_version(arg0);
        let v0 = curator_cap_id(arg1);
        assert_valid_curator_cap(arg0, arg2, v0);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        update_position_value(arg0, arg2, arg3, v1, arg4);
        let v2 = CuratorPositionValueSubmitted{
            curator_position_id : arg2,
            curator_cap_id      : v0,
            position_value      : arg3,
            timestamp_ms        : v1,
            valid_time          : arg4,
        };
        0x2::event::emit<CuratorPositionValueSubmitted>(v2);
    }

    public(friend) fun transfer_curator(arg0: &mut CuratorCap, arg1: address) {
        arg0.curator = arg1;
    }

    public fun transfer_curator_cap_info(arg0: &mut CuratorConfig, arg1: CuratorCap, arg2: address) {
        check_version(arg0);
        let v0 = curator_cap_id(&arg1);
        let v1 = curator_cap_curator_address(&arg1);
        assert!(v1 != arg2, 8009);
        *0x2::table::borrow_mut<address, address>(&mut arg0.curator_cap_to_curator, v0) = arg2;
        let v2 = &mut arg1;
        transfer_curator(v2, arg2);
        0x2::transfer::public_transfer<CuratorCap>(arg1, arg2);
        let v3 = CuratorCapInfoTransferred{
            curator_cap_id : v0,
            old_curator    : v1,
            new_curator    : arg2,
        };
        0x2::event::emit<CuratorCapInfoTransferred>(v3);
    }

    public fun update_curator_position_value<T0>(arg0: &mut CuratorConfig, arg1: &mut 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::Vault<T0>, arg2: 0x1::ascii::String, arg3: address, arg4: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault_oracle::OracleConfig, arg5: &0x2::clock::Clock) {
        check_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert_valid_curator_position_value(arg0, arg3, v0);
        let v1 = 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault_utils::mul_with_oracle_price(position_value(arg0, arg3), 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault_oracle::get_asset_price(arg4, arg5, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::finish_update_asset_value<T0>(arg1, arg2, v1, v0);
        let v2 = CuratorPositionValueUpdated{
            curator_position_id : arg3,
            position_value      : v1,
            timestamp_ms        : v0,
        };
        0x2::event::emit<CuratorPositionValueUpdated>(v2);
    }

    public(friend) fun update_position_value(arg0: &mut CuratorConfig, arg1: address, arg2: u256, arg3: u64, arg4: u64) {
        check_version(arg0);
        let v0 = 0x2::table::borrow_mut<address, CuratorPositionValue>(&mut arg0.curator_position_values, arg1);
        v0.valid = false;
        v0.position_value = arg2;
        v0.position_value_updated = arg3;
        v0.position_value_valid_time = arg4;
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

    public fun validate_curator_position_value(arg0: &mut CuratorConfig, arg1: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::Operation, arg2: &0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::OperatorCap, arg3: address, arg4: bool) {
        check_version(arg0);
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::assert_operator_not_freezed(arg1, arg2);
        0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::vault::assert_single_vault_operator_paired(arg1, *0x2::table::borrow<address, address>(&arg0.curator_position_to_vault, arg3), arg2);
        let v0 = 0x2::table::borrow_mut<address, CuratorPositionValue>(&mut arg0.curator_position_values, arg3);
        if (arg4) {
            let v1 = 0x1::ascii::string(b"333");
            0x1::debug::print<0x1::ascii::String>(&v1);
            v0.valid = true;
            let v2 = CuratorPositionValueApproved{
                curator_position_id : arg3,
                position_value      : v0.position_value,
            };
            0x2::event::emit<CuratorPositionValueApproved>(v2);
        } else {
            let v3 = 0x1::ascii::string(b"222");
            0x1::debug::print<0x1::ascii::String>(&v3);
            v0.valid = false;
            let v4 = CuratorPositionValueDenied{
                curator_position_id : arg3,
                position_value      : v0.position_value,
            };
            0x2::event::emit<CuratorPositionValueDenied>(v4);
        };
    }

    // decompiled from Move bytecode v6
}

