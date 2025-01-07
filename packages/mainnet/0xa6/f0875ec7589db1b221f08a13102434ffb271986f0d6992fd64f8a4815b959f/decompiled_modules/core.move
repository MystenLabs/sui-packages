module 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::core {
    struct Registry<T0: copy + drop + store, T1: copy + drop + store> has key {
        id: 0x2::object::UID,
        key_to_value: 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::IterableTable<T0, T1>,
        uids: 0x2::table::Table<T0, Nothing>,
        approvers: vector<address>,
    }

    struct Nothing has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        package_version: u64,
    }

    struct List<T0: copy + drop + store> has key {
        id: 0x2::object::UID,
        keys: 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::IterableTable<T0, Nothing>,
        approvers: vector<address>,
    }

    struct FullList<T0: copy + drop + store> has copy, drop, store {
        value_list: vector<T0>,
    }

    struct InitRegistryEvent<phantom T0: copy> has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct InitListEvent<phantom T0: copy> has copy, drop {
        list_id: 0x2::object::ID,
    }

    public(friend) fun add_approver_to_list<T0: copy + drop + store>(arg0: address, arg1: &mut List<T0>) {
        assert!(!0x1::vector::contains<address>(&arg1.approvers, &arg0), 0);
        0x1::vector::push_back<address>(&mut arg1.approvers, arg0);
    }

    public(friend) fun add_approver_to_registry<T0: copy + drop + store, T1: copy + drop + store>(arg0: address, arg1: &mut Registry<T0, T1>) {
        assert!(!0x1::vector::contains<address>(&arg1.approvers, &arg0), 0);
        0x1::vector::push_back<address>(&mut arg1.approvers, arg0);
    }

    public(friend) fun add_to_list<T0: copy + drop + store, T1: copy + drop + store>(arg0: T0, arg1: &mut Registry<T0, T1>, arg2: &mut List<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_key_registered<T0, T1>(arg0, arg1), 3);
        assert!(0x1::vector::contains<address>(&arg2.approvers, &v0), 5);
        let v1 = Nothing{dummy_field: false};
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::add<T0, Nothing>(&mut arg2.keys, arg0, v1);
    }

    fun add_to_registry<T0: copy + drop + store, T1: copy + drop + store>(arg0: T0, arg1: T1, arg2: bool, arg3: &mut Registry<T0, T1>) {
        if (!arg2) {
            assert!(!0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::contains<T0, T1>(&arg3.key_to_value, arg0), 2);
            assert!(!0x2::table::contains<T0, Nothing>(&arg3.uids, arg0), 6);
        } else {
            0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::remove<T0, T1>(&mut arg3.key_to_value, arg0);
            if (0x2::table::contains<T0, Nothing>(&arg3.uids, arg0)) {
                0x2::table::remove<T0, Nothing>(&mut arg3.uids, arg0);
            };
        };
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::add<T0, T1>(&mut arg3.key_to_value, arg0, arg1);
        let v0 = Nothing{dummy_field: false};
        0x2::table::add<T0, Nothing>(&mut arg3.uids, arg0, v0);
    }

    public(friend) fun add_to_registry_by_approver<T0: copy + drop + store, T1: copy + drop + store>(arg0: T0, arg1: T1, arg2: bool, arg3: &mut Registry<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg3.approvers, &v0), 5);
        add_to_registry<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun add_to_registry_by_proof<T0: copy + drop + store, T1: copy + drop + store, T2>(arg0: &T2, arg1: T0, arg2: T1, arg3: bool, arg4: &mut Registry<T0, T1>) {
        add_to_registry<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public(friend) fun add_to_registry_by_signer<T0: copy + drop + store, T1: copy + drop + store>(arg0: T0, arg1: T1, arg2: bool, arg3: &mut Registry<T0, T1>) {
        add_to_registry<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 8);
    }

    public(friend) fun create_list<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = List<T0>{
            id        : 0x2::object::new(arg0),
            keys      : 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::new<T0, Nothing>(arg0),
            approvers : v1,
        };
        0x2::transfer::transfer<List<T0>>(v2, v0);
        let v3 = InitListEvent<T0>{list_id: 0x2::object::id<List<T0>>(&v2)};
        0x2::event::emit<InitListEvent<T0>>(v3);
    }

    public(friend) fun get_all_registered_coin_info<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut FullList<T1>, arg1: &mut Registry<T0, T1>) {
        let v0 = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::tail_key<T0, T1>(&arg1.key_to_value);
        while (0x1::option::is_some<T0>(&v0)) {
            let v1 = *0x1::option::borrow<T0>(&v0);
            0x1::vector::push_back<T1>(&mut arg0.value_list, *0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow<T0, T1>(&arg1.key_to_value, v1));
            let (_, v3, _) = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow_iter<T0, T1>(&arg1.key_to_value, v1);
            v0 = v3;
        };
    }

    public(friend) fun get_all_registered_coin_info_with_limit<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut FullList<T1>, arg1: &mut Registry<T0, T1>, arg2: u64, arg3: u64) {
        let v0 = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::tail_key<T0, T1>(&arg1.key_to_value);
        let v1 = 0;
        while (0x1::option::is_some<T0>(&v0)) {
            let v2 = *0x1::option::borrow<T0>(&v0);
            if (arg2 <= v1) {
                0x1::vector::push_back<T1>(&mut arg0.value_list, *0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow<T0, T1>(&arg1.key_to_value, v2));
            };
            let (_, v4, _) = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow_iter<T0, T1>(&arg1.key_to_value, v2);
            v0 = v4;
            v1 = v1 + 1;
            if (0x1::vector::length<T1>(&arg0.value_list) == arg3) {
                break
            };
        };
    }

    public(friend) fun get_complete_address(arg0: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(0x1::ascii::string(b"0x"));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(arg0));
        0x1::ascii::string(v0)
    }

    public(friend) fun get_full_list<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut List<T0>, arg1: &mut FullList<T1>, arg2: &mut Registry<T0, T1>) {
        let v0 = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::tail_key<T0, Nothing>(&arg0.keys);
        while (0x1::option::is_some<T0>(&v0)) {
            let v1 = *0x1::option::borrow<T0>(&v0);
            0x1::vector::push_back<T1>(&mut arg1.value_list, *0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow<T0, T1>(&arg2.key_to_value, v1));
            let (_, v3, _) = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow_iter<T0, Nothing>(&arg0.keys, v1);
            v0 = v3;
        };
    }

    public(friend) fun get_full_list_with_limit<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut List<T0>, arg1: &mut FullList<T1>, arg2: &mut Registry<T0, T1>, arg3: u64, arg4: u64) {
        let v0 = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::tail_key<T0, Nothing>(&arg0.keys);
        let v1 = 0;
        while (0x1::option::is_some<T0>(&v0)) {
            let v2 = *0x1::option::borrow<T0>(&v0);
            if (arg3 <= v1) {
                0x1::vector::push_back<T1>(&mut arg1.value_list, *0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow<T0, T1>(&arg2.key_to_value, v2));
            };
            let (_, v4, _) = 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow_iter<T0, Nothing>(&arg0.keys, v2);
            v0 = v4;
            v1 = v1 + 1;
            if (0x1::vector::length<T1>(&arg1.value_list) == arg4) {
                break
            };
        };
    }

    public(friend) fun get_info<T0: copy + drop + store, T1: copy + drop + store>(arg0: T0, arg1: &mut Registry<T0, T1>) : T1 {
        *0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow<T0, T1>(&arg1.key_to_value, arg0)
    }

    public(friend) fun initialize<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = Registry<T0, T1>{
            id           : 0x2::object::new(arg0),
            key_to_value : 0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::new<T0, T1>(arg0),
            uids         : 0x2::table::new<T0, Nothing>(arg0),
            approvers    : v1,
        };
        0x2::transfer::share_object<Registry<T0, T1>>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, v0);
        let v4 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            package_version : 1,
        };
        0x2::transfer::share_object<GlobalConfig>(v4);
        let v5 = InitRegistryEvent<T0>{registry_id: 0x2::object::id<Registry<T0, T1>>(&v2)};
        0x2::event::emit<InitRegistryEvent<T0>>(v5);
        create_list<T0>(arg0);
    }

    public(friend) fun is_key_in_list<T0: copy + drop + store>(arg0: T0, arg1: &mut List<T0>) : bool {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::contains<T0, Nothing>(&arg1.keys, arg0)
    }

    public(friend) fun is_key_registered<T0: copy + drop + store, T1: copy + drop + store>(arg0: T0, arg1: &mut Registry<T0, T1>) : bool {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::contains<T0, T1>(&arg1.key_to_value, arg0)
    }

    public(friend) fun is_registry_approvers<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut Registry<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&arg0.approvers, &v0)
    }

    public(friend) fun new_full_list<T0: copy + drop + store>() : FullList<T0> {
        FullList<T0>{value_list: 0x1::vector::empty<T0>()}
    }

    public(friend) fun remove_approver_from_list<T0: copy + drop + store>(arg0: address, arg1: &mut List<T0>) {
        assert!(0x1::vector::contains<address>(&arg1.approvers, &arg0), 0);
        let (_, v1) = 0x1::vector::index_of<address>(&arg1.approvers, &arg0);
        0x1::vector::remove<address>(&mut arg1.approvers, v1);
    }

    public(friend) fun remove_approver_from_registry<T0: copy + drop + store, T1: copy + drop + store>(arg0: address, arg1: &mut Registry<T0, T1>) {
        assert!(0x1::vector::contains<address>(&arg1.approvers, &arg0), 0);
        let (_, v1) = 0x1::vector::index_of<address>(&arg1.approvers, &arg0);
        0x1::vector::remove<address>(&mut arg1.approvers, v1);
    }

    public(friend) fun remove_from_list<T0: copy + drop + store>(arg0: T0, arg1: &mut List<T0>) {
        0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::remove<T0, Nothing>(&mut arg1.keys, arg0);
    }

    public(friend) fun remove_from_registry_by_approver<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) {
        abort 7
    }

    public(friend) fun remove_from_registry_by_proof<T0: copy + drop + store, T1: store, T2>(arg0: &T2) {
        abort 7
    }

    public(friend) fun remove_from_registry_by_signer<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) {
        abort 7
    }

    public(friend) fun set_info<T0: copy + drop + store, T1: copy + drop + store>(arg0: T0, arg1: T1, arg2: &mut Registry<T0, T1>) {
        *0xa6f0875ec7589db1b221f08a13102434ffb271986f0d6992fd64f8a4815b959f::iterable_table::borrow_mut<T0, T1>(&mut arg2.key_to_value, arg0) = arg1;
    }

    // decompiled from Move bytecode v6
}

