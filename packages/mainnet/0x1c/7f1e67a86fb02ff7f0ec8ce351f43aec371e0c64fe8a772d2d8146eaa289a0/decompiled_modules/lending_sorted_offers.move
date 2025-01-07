module 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_sorted_offers {
    struct Node has drop, store {
        exists: bool,
        next_id: 0x1::option::Option<0x2::object::ID>,
        prev_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LendingSortedOffersStorage has key {
        id: 0x2::object::UID,
        collections: 0x2::table::Table<0x1::ascii::String, Offers>,
    }

    struct Offers has store {
        head: 0x1::option::Option<0x2::object::ID>,
        tail: 0x1::option::Option<0x2::object::ID>,
        size: u64,
        node_table: 0x2::table::Table<0x2::object::ID, Node>,
    }

    public fun contains(arg0: &LendingSortedOffersStorage, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x1::ascii::String, Offers>(&arg0.collections, arg1)) {
            return false
        };
        0x2::table::contains<0x2::object::ID, Node>(&0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg1).node_table, arg2)
    }

    public(friend) fun remove(arg0: &mut LendingSortedOffersStorage, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) {
        remove_node(arg0, arg1, arg2);
    }

    fun ascend_list<T0>(arg0: &LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x2::object::ID) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg2);
        if (0x1::option::destroy_some<0x2::object::ID>(v0.tail) == arg4 && arg3 <= 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_value_from_collection<T0>(arg1, arg2, arg4)) {
            return (0x1::option::some<0x2::object::ID>(arg4), 0x1::option::none<0x2::object::ID>())
        };
        let v1 = 0x1::option::some<0x2::object::ID>(arg4);
        let v2 = 0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, arg4).prev_id;
        while (0x1::option::is_some<0x2::object::ID>(&v2) && !check_node_position<T0>(arg0, arg1, arg2, arg3, v1, v2)) {
            v1 = 0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, 0x1::option::destroy_some<0x2::object::ID>(v2)).prev_id;
            let v3 = &0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, 0x1::option::destroy_some<0x2::object::ID>(v2)).prev_id;
            v2 = *v3;
        };
        (v1, v2)
    }

    public fun check_insert_position<T0>(arg0: &mut LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>) : bool {
        check_node_position<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun check_node_position<T0>(arg0: &LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>) : bool {
        let v0 = 0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg2);
        if (0x1::option::is_none<0x2::object::ID>(&arg4) && 0x1::option::is_none<0x2::object::ID>(&arg5)) {
            is_empty(arg0, arg2)
        } else if (0x1::option::is_none<0x2::object::ID>(&arg4) && 0x1::option::is_some<0x2::object::ID>(&arg5)) {
            v0.head == arg5 && arg3 >= 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_value_from_collection<T0>(arg1, arg2, 0x1::option::destroy_some<0x2::object::ID>(arg5))
        } else if (0x1::option::is_none<0x2::object::ID>(&arg5) && 0x1::option::is_some<0x2::object::ID>(&arg4)) {
            v0.tail == arg4 && arg3 <= 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_value_from_collection<T0>(arg1, arg2, 0x1::option::destroy_some<0x2::object::ID>(arg4))
        } else {
            0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, 0x1::option::destroy_some<0x2::object::ID>(arg4)).next_id == arg5 && 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_value_from_collection<T0>(arg1, arg2, 0x1::option::destroy_some<0x2::object::ID>(arg4)) >= arg3 && arg3 >= 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_value_from_collection<T0>(arg1, arg2, 0x1::option::destroy_some<0x2::object::ID>(arg5))
        }
    }

    public(friend) fun create_collection_node(arg0: &mut LendingSortedOffersStorage, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Offers{
            head       : 0x1::option::none<0x2::object::ID>(),
            tail       : 0x1::option::none<0x2::object::ID>(),
            size       : 0,
            node_table : 0x2::table::new<0x2::object::ID, Node>(arg2),
        };
        0x2::table::add<0x1::ascii::String, Offers>(&mut arg0.collections, arg1, v0);
    }

    fun descend_list<T0>(arg0: &LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x2::object::ID) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg2);
        if (0x1::option::destroy_some<0x2::object::ID>(v0.head) == arg4 && arg3 >= 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_value_from_collection<T0>(arg1, arg2, arg4)) {
            return (0x1::option::none<0x2::object::ID>(), 0x1::option::some<0x2::object::ID>(arg4))
        };
        let v1 = 0x1::option::some<0x2::object::ID>(arg4);
        let v2 = 0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, arg4).next_id;
        while (0x1::option::is_some<0x2::object::ID>(&v1) && !check_node_position<T0>(arg0, arg1, arg2, arg3, v1, v2)) {
            let v3 = &0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, 0x1::option::destroy_some<0x2::object::ID>(v1)).next_id;
            v1 = *v3;
            v2 = 0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, 0x1::option::destroy_some<0x2::object::ID>(v1)).next_id;
        };
        (v1, v2)
    }

    public fun find_insert_position<T0>(arg0: &mut LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        find_node_position<T0>(arg0, arg1, arg2, arg3, arg5, arg4)
    }

    fun find_node_position<T0>(arg0: &LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        let v0 = arg4;
        let v1 = arg5;
        if (0x1::option::is_some<0x2::object::ID>(&v0)) {
            if (!contains(arg0, arg2, 0x1::option::destroy_some<0x2::object::ID>(v0)) || arg3 > 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_value_from_collection<T0>(arg1, arg2, 0x1::option::destroy_some<0x2::object::ID>(v0))) {
                v0 = 0x1::option::none<0x2::object::ID>();
            };
        };
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            if (!contains(arg0, arg2, 0x1::option::destroy_some<0x2::object::ID>(v1)) || arg3 > 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_value_from_collection<T0>(arg1, arg2, 0x1::option::destroy_some<0x2::object::ID>(v1))) {
                v1 = 0x1::option::none<0x2::object::ID>();
            };
        };
        if (0x1::option::is_none<0x2::object::ID>(&v0) && 0x1::option::is_none<0x2::object::ID>(&v1)) {
            return descend_list<T0>(arg0, arg1, arg2, arg3, 0x1::option::destroy_some<0x2::object::ID>(0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg2).head))
        };
        if (0x1::option::is_none<0x2::object::ID>(&v0)) {
            return ascend_list<T0>(arg0, arg1, arg2, arg3, 0x1::option::destroy_some<0x2::object::ID>(v1))
        };
        if (0x1::option::is_none<0x2::object::ID>(&v1)) {
            return descend_list<T0>(arg0, arg1, arg2, arg3, 0x1::option::destroy_some<0x2::object::ID>(v0))
        };
        descend_list<T0>(arg0, arg1, arg2, arg3, 0x1::option::destroy_some<0x2::object::ID>(v0))
    }

    public fun get_first(arg0: &LendingSortedOffersStorage, arg1: 0x1::ascii::String) : 0x1::option::Option<0x2::object::ID> {
        0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg1).head
    }

    public fun get_last(arg0: &LendingSortedOffersStorage, arg1: 0x1::ascii::String) : 0x1::option::Option<0x2::object::ID> {
        0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg1).tail
    }

    public fun get_next(arg0: &LendingSortedOffersStorage, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        0x2::table::borrow<0x2::object::ID, Node>(&0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg1).node_table, arg2).next_id
    }

    public(friend) fun get_offers_paginated_<T0>(arg0: &LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<address>, arg5: 0x1::option::Option<bool>, arg6: 0x1::option::Option<bool>, arg7: 0x1::option::Option<bool>, arg8: 0x1::option::Option<u8>, arg9: 0x1::option::Option<0x2::object::ID>) : vector<0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::OfferResponse> {
        let v0 = 20;
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::OfferResponse>();
        let v3 = 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::read_collection<T0>(arg1, arg2);
        let v4 = if (0x1::option::is_some<0x2::object::ID>(&arg9)) {
            let v5 = get_next(arg0, arg2, 0x1::option::destroy_some<0x2::object::ID>(arg9));
            if (0x1::option::is_none<0x2::object::ID>(&v5)) {
                return 0x1::vector::empty<0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::OfferResponse>()
            };
            v5
        } else {
            get_first(arg0, arg2)
        };
        if (0x1::option::is_some<u8>(&arg8)) {
            v0 = 0x1::option::destroy_some<u8>(arg8);
        };
        while (0x1::option::is_some<0x2::object::ID>(&v4) && v1 < v0) {
            let v6 = 0x1::option::destroy_some<0x2::object::ID>(v4);
            let v7 = 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::read_offer<T0>(v3, v6);
            let v8 = true;
            if (0x1::option::is_some<address>(&arg3)) {
                v8 = 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_owner(v7) == 0x1::option::destroy_some<address>(arg3);
            };
            if (v8 && 0x1::option::is_some<address>(&arg4)) {
                v8 = 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_borrower(v7) == 0x1::option::destroy_some<address>(arg4);
            };
            if (v8 && 0x1::option::is_some<bool>(&arg5)) {
                v8 = 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_is_started(v7) == 0x1::option::destroy_some<bool>(arg5);
            };
            if (v8 && 0x1::option::is_some<bool>(&arg6)) {
                v8 = 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_is_repaid(v7) == 0x1::option::destroy_some<bool>(arg6);
            };
            if (v8 && 0x1::option::is_some<bool>(&arg7)) {
                v8 = 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::get_offer_is_claimed(v7) == 0x1::option::destroy_some<bool>(arg7);
            };
            if (v8) {
                0x1::vector::push_back<0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::OfferResponse>(&mut v2, 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::create_offer_response<T0>(arg2, v7));
                v1 = v1 + 1;
            };
            v4 = get_next(arg0, arg2, v6);
        };
        v2
    }

    public fun get_prev(arg0: &LendingSortedOffersStorage, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        0x2::table::borrow<0x2::object::ID, Node>(&0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg1).node_table, arg2).prev_id
    }

    public fun get_size(arg0: &LendingSortedOffersStorage, arg1: 0x1::ascii::String) : u64 {
        0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg1).size
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingSortedOffersStorage{
            id          : 0x2::object::new(arg0),
            collections : 0x2::table::new<0x1::ascii::String, Offers>(arg0),
        };
        0x2::transfer::share_object<LendingSortedOffersStorage>(v0);
    }

    public(friend) fun insert<T0>(arg0: &mut LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: u64, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>) {
        insert_node<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun insert_node<T0>(arg0: &mut LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: u64, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>) {
        let v0 = arg5;
        let v1 = arg6;
        assert!(!contains(arg0, arg2, arg3), 2);
        assert!(arg4 > 0, 3);
        if (!check_node_position<T0>(arg0, arg1, arg2, arg4, v0, v1)) {
            let (v2, v3) = find_node_position<T0>(arg0, arg1, arg2, arg4, v0, v1);
            v1 = v3;
            v0 = v2;
        };
        let v4 = 0x2::table::borrow_mut<0x1::ascii::String, Offers>(&mut arg0.collections, arg2);
        let v5 = Node{
            exists  : true,
            next_id : v1,
            prev_id : v0,
        };
        0x2::table::add<0x2::object::ID, Node>(&mut v4.node_table, arg3, v5);
        if (0x1::option::is_none<0x2::object::ID>(&v0) && 0x1::option::is_none<0x2::object::ID>(&v1)) {
            v4.head = 0x1::option::some<0x2::object::ID>(arg3);
            v4.tail = 0x1::option::some<0x2::object::ID>(arg3);
        } else if (0x1::option::is_none<0x2::object::ID>(&v0)) {
            0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v4.node_table, arg3).next_id = v4.head;
            0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v4.node_table, 0x1::option::destroy_some<0x2::object::ID>(v4.head)).prev_id = 0x1::option::some<0x2::object::ID>(arg3);
            v4.head = 0x1::option::some<0x2::object::ID>(arg3);
        } else if (0x1::option::is_none<0x2::object::ID>(&v1)) {
            0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v4.node_table, arg3).prev_id = v4.tail;
            0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v4.node_table, 0x1::option::destroy_some<0x2::object::ID>(v4.tail)).next_id = 0x1::option::some<0x2::object::ID>(arg3);
            v4.tail = 0x1::option::some<0x2::object::ID>(arg3);
        } else {
            0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v4.node_table, arg3).prev_id = v0;
            0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v4.node_table, arg3).next_id = v1;
            0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v4.node_table, 0x1::option::destroy_some<0x2::object::ID>(v0)).next_id = 0x1::option::some<0x2::object::ID>(arg3);
            0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v4.node_table, 0x1::option::destroy_some<0x2::object::ID>(v1)).prev_id = 0x1::option::some<0x2::object::ID>(arg3);
        };
        v4.size = v4.size + 1;
    }

    public fun is_empty(arg0: &LendingSortedOffersStorage, arg1: 0x1::ascii::String) : bool {
        0x2::table::borrow<0x1::ascii::String, Offers>(&arg0.collections, arg1).size == 0
    }

    public(friend) fun reinsert<T0>(arg0: &mut LendingSortedOffersStorage, arg1: &0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::lending_storage::LendingStorage, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: u64, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>) {
        assert!(contains(arg0, arg2, arg3), 2);
        assert!(arg4 > 0, 3);
        remove_node(arg0, arg2, arg3);
        insert_node<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun remove_node(arg0: &mut LendingSortedOffersStorage, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) {
        assert!(contains(arg0, arg1, arg2), 2);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, Offers>(&mut arg0.collections, arg1);
        if (v0.size > 1) {
            if (0x1::option::is_some<0x2::object::ID>(&v0.head) && arg2 == 0x1::option::destroy_some<0x2::object::ID>(v0.head)) {
                v0.head = 0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, arg2).next_id;
                0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v0.node_table, 0x1::option::destroy_some<0x2::object::ID>(v0.head)).prev_id = 0x1::option::none<0x2::object::ID>();
            } else if (0x1::option::is_some<0x2::object::ID>(&v0.tail) && arg2 == 0x1::option::destroy_some<0x2::object::ID>(v0.tail)) {
                v0.tail = 0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, arg2).prev_id;
                0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v0.node_table, 0x1::option::destroy_some<0x2::object::ID>(v0.tail)).next_id = 0x1::option::none<0x2::object::ID>();
            } else {
                0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v0.node_table, 0x1::option::destroy_some<0x2::object::ID>(0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, arg2).prev_id)).next_id = 0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, arg2).next_id;
                0x2::table::borrow_mut<0x2::object::ID, Node>(&mut v0.node_table, 0x1::option::destroy_some<0x2::object::ID>(0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, arg2).next_id)).prev_id = 0x2::table::borrow<0x2::object::ID, Node>(&v0.node_table, arg2).prev_id;
            };
        } else {
            v0.head = 0x1::option::none<0x2::object::ID>();
            v0.tail = 0x1::option::none<0x2::object::ID>();
        };
        0x2::table::remove<0x2::object::ID, Node>(&mut v0.node_table, arg2);
        v0.size = v0.size - 1;
    }

    // decompiled from Move bytecode v6
}

