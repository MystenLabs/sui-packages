module 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::ACL,
        package_version: u64,
        allow_quotes: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        protocol_fees: 0x2::bag::Bag,
        inscription_account: 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::Account,
        confirmed_limit: u64,
        delete_grace: u64,
        skip_verify: bool,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct AddQuoteCoinEvent has copy, drop {
        quote_coin: 0x1::type_name::TypeName,
        protocol_fee_rate: u64,
    }

    struct UpdateProtocolFeeEvent has copy, drop {
        quote_coin: 0x1::type_name::TypeName,
        protocol_fee_rate: u64,
    }

    struct UpdateConfirmedLimit has copy, drop {
        old_limit: u64,
        new_limit: u64,
    }

    struct CollectProtocolFeeEvent has copy, drop {
        quote_coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SetPackageVersionEvent has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct QuoteCoinWithFee has copy, drop, store {
        quote_coin: 0x1::string::String,
        protocol_fee_rate: u64,
    }

    struct FetchQuoteCoinListEvent has copy, drop, store {
        list: vector<QuoteCoinWithFee>,
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::Member> {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        checked_package_version(arg1);
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun add_quote_coin<T0>(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 <= 5000, 5);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.allow_quotes, &v0), 8);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.allow_quotes, v0, arg2);
        let v1 = AddQuoteCoinEvent{
            quote_coin        : v0,
            protocol_fee_rate : arg2,
        };
        0x2::event::emit<AddQuoteCoinEvent>(v1);
    }

    public fun check_validator_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::has_role(&arg0.acl, arg1, 1), 2);
    }

    public fun check_validator_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::has_role(&arg0.acl, arg1, 2), 3);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(2 >= arg0.package_version, 1);
    }

    public fun checked_quote_coin<T0>(arg0: &GlobalConfig) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.allow_quotes, &v0), 6);
    }

    public fun collect_protocol_fee<T0>(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.protocol_fees, v0), 9);
        assert!(0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg2), 3), 4);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v2), arg2), arg1);
        let v3 = CollectProtocolFeeEvent{
            quote_coin : 0x1::type_name::get<T0>(),
            amount     : v2,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v3);
    }

    public fun fetch_quote_coin_list(arg0: &GlobalConfig) {
        let v0 = 0x1::vector::empty<QuoteCoinWithFee>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&arg0.allow_quotes)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&arg0.allow_quotes, v1);
            let v4 = QuoteCoinWithFee{
                quote_coin        : 0x1::string::from_ascii(0x1::type_name::into_string(*v2)),
                protocol_fee_rate : *v3,
            };
            0x1::vector::insert<QuoteCoinWithFee>(&mut v0, v4, v1);
            v1 = v1 + 1;
        };
        let v5 = FetchQuoteCoinListEvent{list: v0};
        0x2::event::emit<FetchQuoteCoinListEvent>(v5);
    }

    public fun get_confirmed_limit(arg0: &GlobalConfig) : u64 {
        arg0.confirmed_limit
    }

    public fun get_delete_grace(arg0: &GlobalConfig) : u64 {
        arg0.delete_grace
    }

    public fun get_protocol_fee_rate<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.allow_quotes, &v0)
    }

    public fun has_validator_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::has_role(&arg0.acl, arg1, 2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                  : 0x2::object::new(arg0),
            acl                 : 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::acl::new(arg0),
            package_version     : 1,
            allow_quotes        : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            protocol_fees       : 0x2::bag::new(arg0),
            inscription_account : 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::create_account(arg0),
            confirmed_limit     : 1,
            delete_grace        : 2592000000,
            skip_verify         : false,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.allow_quotes, 0x1::type_name::get<0x2::sui::SUI>(), 1000);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v2 = InitConfigEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v1),
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
        };
        0x2::event::emit<InitConfigEvent>(v2);
    }

    public fun max_protocol_fee_rate() : u64 {
        5000
    }

    public fun package_version() : u64 {
        2
    }

    public fun protocol_fee_denom() : u64 {
        10000
    }

    public fun receive_protocol_fee<T0>(arg0: &mut GlobalConfig, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.protocol_fees, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0), arg1);
    }

    public fun set_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersionEvent>(v0);
    }

    public fun skip_verify(arg0: &GlobalConfig) : bool {
        arg0.skip_verify
    }

    public(friend) fun transfer_from_vault(arg0: &GlobalConfig, arg1: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::transfer_from(&arg0.inscription_account, arg1, arg2, arg3)
    }

    public(friend) fun transfer_to_vault(arg0: &GlobalConfig, arg1: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::transfer(&arg0.inscription_account, arg1, arg2)
    }

    public fun update_confirmed_limit(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > 0, 7);
        arg1.confirmed_limit = arg2;
        let v0 = UpdateConfirmedLimit{
            old_limit : arg1.confirmed_limit,
            new_limit : arg2,
        };
        0x2::event::emit<UpdateConfirmedLimit>(v0);
    }

    public fun update_delete_grace(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.delete_grace = arg2;
    }

    public fun update_protocol_fee_rate<T0>(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 <= 5000, 5);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.allow_quotes, &v0), 6);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.allow_quotes, v0, arg2);
        let v1 = UpdateProtocolFeeEvent{
            quote_coin        : v0,
            protocol_fee_rate : arg2,
        };
        0x2::event::emit<UpdateProtocolFeeEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

