module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config {
    struct GroupMaxHolderRule has drop {
        dummy_field: bool,
    }

    struct AddressInfo has copy, drop, store {
        holder_id: u64,
        group_id: u64,
    }

    struct HolderAddressAdded<phantom T0> has copy, drop {
        holder_id: u64,
        addr: address,
    }

    struct HolderAddressRemoved<phantom T0> has copy, drop {
        addr: address,
        holder_id: u64,
    }

    struct GroupHolderMaxSet<phantom T0> has copy, drop {
        group_id: u64,
        max_holders: 0x1::option::Option<u64>,
    }

    struct GroupAdded<phantom T0> has copy, drop {
        group_id: u64,
        name: 0x1::string::String,
    }

    struct GroupRemoved<phantom T0> has copy, drop {
        group_id: u64,
        name: 0x1::string::String,
    }

    struct GroupRenamed<phantom T0> has copy, drop {
        group_id: u64,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
    }

    struct HolderAdded<phantom T0> has copy, drop {
        holder_id: u64,
        addresses: vector<address>,
    }

    struct HolderRemoved<phantom T0> has copy, drop {
        sender: address,
        holder_id: u64,
    }

    struct AddressJoinedGroup<phantom T0> has copy, drop {
        sender: address,
        addr: address,
        group_id: u64,
    }

    struct AddressLeftGroup<phantom T0> has copy, drop {
        sender: address,
        addr: address,
        group_id: u64,
    }

    struct Config has store {
        groups: 0x2::vec_map::VecMap<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>,
        holders: 0x2::table::Table<u64, 0x2::vec_set::VecSet<address>>,
        addresses: 0x2::table::Table<address, AddressInfo>,
        next_holder: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let v1 = Config{
            groups      : 0x2::vec_map::empty<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(),
            holders     : 0x2::table::new<u64, 0x2::vec_set::VecSet<address>>(arg2),
            addresses   : 0x2::table::new<address, AddressInfo>(arg2),
            next_holder : 0,
        };
        0x2::token::add_rule_config<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1, v1, arg2);
        add_group<T0>(arg0, arg1, default_group(), 0x1::string::utf8(b"Default Group"), 0x1::option::none<u64>(), arg2);
    }

    public fun remove<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : Config {
        0x2::token::remove_rule_config<T0, GroupMaxHolderRule, Config>(arg0, arg1, arg2)
    }

    public fun add_holder_address<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: address) {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1);
        assert!(!0x2::table::contains<address, AddressInfo>(&v1.addresses, arg3), 0);
        add_holder_address_internal<T0>(v1, arg2, arg3, 0);
    }

    public fun remove_holder<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1);
        let v2 = default_group();
        let v3 = 0x2::vec_map::get_mut<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut v1.groups, &v2);
        let v4 = if (0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::contains_holder(v3, arg2)) {
            0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::remove_holder(v3, arg2)
        } else {
            0x2::vec_set::empty<address>()
        };
        let v5 = v4;
        let v6 = 0x2::vec_set::into_keys<address>(0x2::table::remove<u64, 0x2::vec_set::VecSet<address>>(&mut v1.holders, arg2));
        assert!(0x2::vec_set::size<address>(&v5) == 0x1::vector::length<address>(&v6), 2);
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&v6)) {
            let v8 = 0x2::table::remove<address, AddressInfo>(&mut v1.addresses, 0x1::vector::pop_back<address>(&mut v6));
            assert!(v8.group_id == 0, 2);
            assert!(v8.holder_id == arg2, 3);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<address>(v6);
        let v9 = HolderRemoved<T0>{
            sender    : 0x2::tx_context::sender(arg3),
            holder_id : arg2,
        };
        0x2::event::emit<HolderRemoved<T0>>(v9);
    }

    public fun remove_holder_address<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: address) {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1);
        0x2::vec_set::remove<address>(0x2::table::borrow_mut<u64, 0x2::vec_set::VecSet<address>>(&mut v1.holders, arg2), &arg3);
        let v2 = 0x2::table::remove<address, AddressInfo>(&mut v1.addresses, arg3);
        assert!(v2.holder_id == arg2, 3);
        assert!(v2.group_id == 0, 2);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::remove_holder_address(0x2::vec_map::get_mut<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut v1.groups, &v2.group_id), arg2, arg3);
        let v3 = HolderAddressRemoved<T0>{
            addr      : arg3,
            holder_id : arg2,
        };
        0x2::event::emit<HolderAddressRemoved<T0>>(v3);
    }

    public fun add_address_to_group<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1);
        let v2 = 0x2::table::borrow_mut<address, AddressInfo>(&mut v1.addresses, arg2);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::remove_holder_address(0x2::vec_map::get_mut<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut v1.groups, &v2.group_id), v2.holder_id, arg2);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::add_holder_address(0x2::vec_map::get_mut<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut v1.groups, &arg3), v2.holder_id, arg2);
        v2.group_id = arg3;
        assert!(0x2::vec_set::contains<address>(0x2::table::borrow<u64, 0x2::vec_set::VecSet<address>>(&v1.holders, v2.holder_id), &arg2), 3);
        let v3 = AddressJoinedGroup<T0>{
            sender   : 0x2::tx_context::sender(arg4),
            addr     : arg2,
            group_id : arg3,
        };
        0x2::event::emit<AddressJoinedGroup<T0>>(v3);
    }

    public fun add_group<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        0x2::vec_map::insert<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1).groups, arg2, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::new(arg3, arg4, arg5));
        let v1 = GroupAdded<T0>{
            group_id : arg2,
            name     : arg3,
        };
        0x2::event::emit<GroupAdded<T0>>(v1);
        let v2 = GroupHolderMaxSet<T0>{
            group_id    : arg2,
            max_holders : arg4,
        };
        0x2::event::emit<GroupHolderMaxSet<T0>>(v2);
    }

    public fun add_holder<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: vector<address>) : u64 {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1);
        let v2 = v1.next_holder;
        v1.next_holder = v2 + 1;
        0x2::table::add<u64, 0x2::vec_set::VecSet<address>>(&mut v1.holders, v2, 0x2::vec_set::empty<address>());
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg2)) {
            add_holder_address_internal<T0>(v1, v2, 0x1::vector::pop_back<address>(&mut arg2), 0);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        let v4 = HolderAdded<T0>{
            holder_id : v2,
            addresses : arg2,
        };
        0x2::event::emit<HolderAdded<T0>>(v4);
        v2
    }

    fun add_holder_address_internal<T0>(arg0: &mut Config, arg1: u64, arg2: address, arg3: u64) {
        let v0 = HolderAddressAdded<T0>{
            holder_id : arg1,
            addr      : arg2,
        };
        0x2::event::emit<HolderAddressAdded<T0>>(v0);
        0x2::vec_set::insert<address>(0x2::table::borrow_mut<u64, 0x2::vec_set::VecSet<address>>(&mut arg0.holders, arg1), arg2);
        let v1 = AddressInfo{
            holder_id : arg1,
            group_id  : arg3,
        };
        0x2::table::add<address, AddressInfo>(&mut arg0.addresses, arg2, v1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::add_holder_address(0x2::vec_map::get_mut<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut arg0.groups, &arg3), arg1, arg2);
    }

    public fun address_info<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: address) : &AddressInfo {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        0x2::table::borrow<address, AddressInfo>(&0x2::token::rule_config<T0, GroupMaxHolderRule, Config>(v0, arg0).addresses, arg1)
    }

    public fun address_info_group_id(arg0: &AddressInfo) : u64 {
        arg0.group_id
    }

    public fun address_info_holder_id(arg0: &AddressInfo) : u64 {
        arg0.holder_id
    }

    public fun config_drop(arg0: Config) {
        let Config {
            groups      : v0,
            holders     : v1,
            addresses   : v2,
            next_holder : _,
        } = arg0;
        let v4 = v0;
        while (0x2::vec_map::size<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&v4) > 0) {
            let (_, v6) = 0x2::vec_map::pop<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut v4);
            0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::drop(v6);
        };
        0x2::vec_map::destroy_empty<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(v4);
        0x2::table::drop<u64, 0x2::vec_set::VecSet<address>>(v1);
        0x2::table::drop<address, AddressInfo>(v2);
    }

    public fun contains_group<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &u64) : bool {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        0x2::vec_map::contains<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&0x2::token::rule_config<T0, GroupMaxHolderRule, Config>(v0, arg0).groups, arg1)
    }

    public fun default_group() : u64 {
        0
    }

    public fun group_holders<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &u64) : &0x2::linked_table::LinkedTable<u64, 0x2::vec_set::VecSet<address>> {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::holders(0x2::vec_map::get<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&0x2::token::rule_config<T0, GroupMaxHolderRule, Config>(v0, arg0).groups, arg1))
    }

    public fun group_id<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: address) : u64 {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        0x2::table::borrow<address, AddressInfo>(&0x2::token::rule_config<T0, GroupMaxHolderRule, Config>(v0, arg0).addresses, arg1).group_id
    }

    public fun group_max_holders<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &u64) : &0x1::option::Option<u64> {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::max_holders(0x2::vec_map::get<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&0x2::token::rule_config<T0, GroupMaxHolderRule, Config>(v0, arg0).groups, arg1))
    }

    public fun group_name<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &u64) : 0x1::string::String {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::name(0x2::vec_map::get<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&0x2::token::rule_config<T0, GroupMaxHolderRule, Config>(v0, arg0).groups, arg1))
    }

    public fun holder_id<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: address) : u64 {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        0x2::table::borrow<address, AddressInfo>(&0x2::token::rule_config<T0, GroupMaxHolderRule, Config>(v0, arg0).addresses, arg1).holder_id
    }

    public fun is_address_registered<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: address) : bool {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        0x2::table::contains<address, AddressInfo>(&0x2::token::rule_config<T0, GroupMaxHolderRule, Config>(v0, arg0).addresses, arg1)
    }

    public fun remove_address_from_group<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1);
        let v2 = 0x2::table::borrow_mut<address, AddressInfo>(&mut v1.addresses, arg2);
        let v3 = v2.group_id;
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::remove_holder_address(0x2::vec_map::get_mut<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut v1.groups, &v3), v2.holder_id, arg2);
        v2.group_id = 0;
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::add_holder_address(0x2::vec_map::get_mut<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut v1.groups, &v2.group_id), v2.holder_id, arg2);
        let v4 = *0x2::table::borrow<u64, 0x2::vec_set::VecSet<address>>(&v1.holders, v2.holder_id);
        assert!(0x2::vec_set::contains<address>(&v4, &arg2), 3);
        let v5 = AddressLeftGroup<T0>{
            sender   : 0x2::tx_context::sender(arg3),
            addr     : arg2,
            group_id : v3,
        };
        0x2::event::emit<AddressLeftGroup<T0>>(v5);
    }

    public fun remove_group<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64) : (0x1::string::String, 0x2::linked_table::LinkedTable<u64, 0x2::vec_set::VecSet<address>>, 0x1::option::Option<u64>) {
        assert!(arg2 != default_group(), 1);
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let (_, v2) = 0x2::vec_map::remove<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1).groups, &arg2);
        let v3 = v2;
        let v4 = GroupRemoved<T0>{
            group_id : arg2,
            name     : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::name(&v3),
        };
        0x2::event::emit<GroupRemoved<T0>>(v4);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::destroy(v3)
    }

    public fun set_group_max_holders<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: 0x1::option::Option<u64>) {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let v1 = GroupHolderMaxSet<T0>{
            group_id    : arg2,
            max_holders : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::update_max_holders(0x2::vec_map::get_mut<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1).groups, &arg2), arg3),
        };
        0x2::event::emit<GroupHolderMaxSet<T0>>(v1);
    }

    public fun set_group_name<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: 0x1::string::String) {
        let v0 = GroupMaxHolderRule{dummy_field: false};
        let v1 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::name_mut(0x2::vec_map::get_mut<u64, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group::Group>(&mut 0x2::token::rule_config_mut<T0, GroupMaxHolderRule, Config>(v0, arg0, arg1).groups, &arg2));
        let v2 = GroupRenamed<T0>{
            group_id : arg2,
            old_name : *v1,
            new_name : arg3,
        };
        0x2::event::emit<GroupRenamed<T0>>(v2);
        *v1 = arg3;
    }

    // decompiled from Move bytecode v7
}

