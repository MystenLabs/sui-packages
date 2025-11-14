module 0x94cf19d164f014cfe73dda1121f27b54b69f0dbfa89d8b6ed48ae8a9144f5d65::endless_vector {
    struct EndlessVector has store, key {
        id: 0x2::object::UID,
        items: vector<vector<u8>>,
        first_item_is_from_previous_history: bool,
        length: u64,
        binary_length: u64,
        this_object_items_binary_length: u64,
        history: 0x1::option::Option<0x2::table::Table<u64, EndlessVectorHistory>>,
        history_items_count: u64,
        archive: 0x2::table::Table<u64, EndlessVectorArchive>,
        archive_items_count: u64,
        archived_at_length: u64,
        archived_from_length: u64,
        burned_archive_count: u64,
        made_with_version: u64,
        meta: vector<u8>,
    }

    struct EndlessVectorHistory has drop, store {
        items: vector<vector<u8>>,
        followed_by_next_bytes: u64,
        first_item_is_from_previous_history: bool,
        saved_at_length: u64,
    }

    struct EndlessVectorArchive has store, key {
        id: 0x2::object::UID,
        history: 0x2::table::Table<u64, EndlessVectorHistory>,
        archived_at_length: u64,
        length: u64,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : EndlessVector {
        EndlessVector{
            id                                  : 0x2::object::new(arg0),
            items                               : 0x1::vector::empty<vector<u8>>(),
            first_item_is_from_previous_history : false,
            length                              : 0,
            binary_length                       : 0,
            this_object_items_binary_length     : 0,
            history                             : 0x1::option::some<0x2::table::Table<u64, EndlessVectorHistory>>(0x2::table::new<u64, EndlessVectorHistory>(arg0)),
            history_items_count                 : 0,
            archive                             : 0x2::table::new<u64, EndlessVectorArchive>(arg0),
            archive_items_count                 : 0,
            archived_at_length                  : 0,
            archived_from_length                : 0,
            burned_archive_count                : 0,
            made_with_version                   : 1,
            meta                                : 0x1::vector::empty<u8>(),
        }
    }

    public fun length(arg0: &EndlessVector) : u64 {
        arg0.length
    }

    public fun push_back(arg0: &mut EndlessVector, arg1: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        if (v0 > 131072) {
            abort 91
        };
        if (v0 + arg0.this_object_items_binary_length > 131072) {
            clamp(arg0, 0x1::option::some<vector<u8>>(arg1));
        } else {
            0x1::vector::push_back<vector<u8>>(&mut arg0.items, arg1);
            arg0.this_object_items_binary_length = arg0.this_object_items_binary_length + v0;
            arg0.binary_length = arg0.binary_length + v0;
            arg0.length = arg0.length + 1;
        };
    }

    public fun append(arg0: &mut EndlessVector, arg1: vector<EndlessVector>) {
        0x1::vector::reverse<EndlessVector>(&mut arg1);
        while (!0x1::vector::is_empty<EndlessVector>(&arg1)) {
            concat(arg0, 0x1::vector::pop_back<EndlessVector>(&mut arg1));
        };
        0x1::vector::destroy_empty<EndlessVector>(arg1);
    }

    public fun archive(arg0: &mut EndlessVector, arg1: &mut 0x2::tx_context::TxContext) {
        clamp(arg0, 0x1::option::none<vector<u8>>());
        let v0 = EndlessVectorArchive{
            id                 : 0x2::object::new(arg1),
            history            : 0x1::option::swap<0x2::table::Table<u64, EndlessVectorHistory>>(&mut arg0.history, 0x2::table::new<u64, EndlessVectorHistory>(arg1)),
            archived_at_length : arg0.length,
            length             : arg0.length - arg0.archived_at_length,
        };
        0x2::table::add<u64, EndlessVectorArchive>(&mut arg0.archive, arg0.archive_items_count, v0);
        arg0.archive_items_count = arg0.archive_items_count + 1;
        arg0.history_items_count = 0;
        arg0.archived_at_length = arg0.length;
    }

    fun binary_search_archive_by_archived_length(arg0: &EndlessVector, arg1: u64) : u64 {
        if (arg0.archive_items_count == 0) {
            abort 0
        } else {
            let v0 = arg0.burned_archive_count;
            let v1 = arg0.archive_items_count - 1;
            while (v0 <= v1) {
                let v2 = v0 + (v1 - v0) / 2;
                let v3 = 0x2::table::borrow<u64, EndlessVectorArchive>(&arg0.archive, v2);
                let v4 = v3.archived_at_length - v3.length;
                if (arg1 >= v4 && arg1 < v3.archived_at_length) {
                    return v2
                };
                if (arg1 < v4) {
                    if (v2 == 0) {
                        break
                    };
                    v1 = v2 - 1;
                } else {
                    v0 = v2 + 1;
                };
                if (v1 == 0 && v0 > v1) {
                    break
                };
            };
            abort 0
        };
    }

    fun binary_search_archive_history_by_saved_length(arg0: &EndlessVectorArchive, arg1: u64) : u64 {
        let v0 = 0x2::table::length<u64, EndlessVectorHistory>(&arg0.history);
        if (v0 == 0) {
            abort 0
        } else {
            let v1 = 0;
            let v2 = v0 - 1;
            while (v1 <= v2) {
                let v3 = v1 + (v2 - v1) / 2;
                let v4 = 0x2::table::borrow<u64, EndlessVectorHistory>(&arg0.history, v3);
                if (arg1 < v4.saved_at_length) {
                    if (v3 == 0) {
                        return v3
                    };
                    let v5 = if (v4.first_item_is_from_previous_history) {
                        v4.saved_at_length - 0x1::vector::length<vector<u8>>(&v4.items) + 1
                    } else {
                        v4.saved_at_length - 0x1::vector::length<vector<u8>>(&v4.items)
                    };
                    if (arg1 >= v5) {
                        return v3
                    };
                    if (v3 == 0) {
                        break
                    };
                    v2 = v3 - 1;
                } else {
                    v1 = v3 + 1;
                };
                if (v2 == 0 && v1 > v2) {
                    break
                };
            };
            abort 0
        };
    }

    fun binary_search_history_by_saved_length(arg0: &EndlessVector, arg1: u64) : u64 {
        if (arg0.history_items_count == 0) {
            return 0
        };
        let v0 = 0;
        let v1 = arg0.history_items_count - 1;
        while (v0 <= v1) {
            let v2 = v0 + (v1 - v0) / 2;
            let v3 = 0x2::table::borrow<u64, EndlessVectorHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessVectorHistory>>(&arg0.history), v2);
            if (arg1 < v3.saved_at_length) {
                if (v2 == 0) {
                    return v2
                };
                let v4 = if (v3.first_item_is_from_previous_history) {
                    v3.saved_at_length - 0x1::vector::length<vector<u8>>(&v3.items) + 1
                } else {
                    v3.saved_at_length
                };
                if (arg1 >= v4) {
                    return v2
                };
                if (v2 == 0) {
                    break
                };
                v1 = v2 - 1;
            } else {
                v0 = v2 + 1;
            };
            if (v1 == 0 && v0 > v1) {
                break
            };
        };
        arg0.history_items_count - 1
    }

    public fun burn_archive(arg0: &mut EndlessVector) {
        if (arg0.archive_items_count > 0) {
            let EndlessVectorArchive {
                id                 : v0,
                history            : v1,
                archived_at_length : _,
                length             : v3,
            } = 0x2::table::remove<u64, EndlessVectorArchive>(&mut arg0.archive, arg0.burned_archive_count);
            0x2::object::delete(v0);
            0x2::table::drop<u64, EndlessVectorHistory>(v1);
            arg0.burned_archive_count = arg0.burned_archive_count + 1;
            arg0.archived_from_length = arg0.archived_from_length + v3;
        };
    }

    public fun clamp(arg0: &mut EndlessVector, arg1: 0x1::option::Option<vector<u8>>) {
        let v0 = EndlessVectorHistory{
            items                               : arg0.items,
            followed_by_next_bytes              : 0,
            first_item_is_from_previous_history : arg0.first_item_is_from_previous_history,
            saved_at_length                     : arg0.length,
        };
        arg0.first_item_is_from_previous_history = false;
        if (0x1::option::is_some<vector<u8>>(&arg1)) {
            let v1 = 0x1::option::destroy_some<vector<u8>>(arg1);
            arg0.binary_length = arg0.binary_length + 0x1::vector::length<u8>(&v1);
            let v2 = 0x1::vector::length<u8>(&v1) - 131072 - arg0.this_object_items_binary_length;
            let v3 = 0x1::vector::empty<u8>();
            while (v2 > 0) {
                0x1::vector::push_back<u8>(&mut v3, 0x1::vector::pop_back<u8>(&mut v1));
                v2 = v2 - 1;
            };
            0x1::vector::reverse<u8>(&mut v3);
            0x1::vector::push_back<vector<u8>>(&mut v0.items, v1);
            v0.followed_by_next_bytes = 0x1::vector::length<u8>(&v3);
            arg0.this_object_items_binary_length = 0x1::vector::length<u8>(&v3);
            if (arg0.this_object_items_binary_length > 0) {
                arg0.items = 0x1::vector::singleton<vector<u8>>(v3);
                arg0.first_item_is_from_previous_history = true;
                arg0.length = arg0.length + 1;
            } else {
                arg0.items = 0x1::vector::empty<vector<u8>>();
            };
            v0.saved_at_length = arg0.length;
        } else {
            arg0.items = 0x1::vector::empty<vector<u8>>();
            arg0.this_object_items_binary_length = 0;
        };
        0x2::table::add<u64, EndlessVectorHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessVectorHistory>>(&mut arg0.history), arg0.history_items_count, v0);
        arg0.history_items_count = arg0.history_items_count + 1;
    }

    public fun compose_and_push_back(arg0: &mut EndlessVector, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, arg6);
        0x1::vector::append<u8>(&mut v0, arg7);
        0x1::vector::append<u8>(&mut v0, arg8);
        0x1::vector::append<u8>(&mut v0, arg9);
        0x1::vector::append<u8>(&mut v0, arg10);
        push_back(arg0, v0);
    }

    public fun concat(arg0: &mut EndlessVector, arg1: EndlessVector) {
        let EndlessVector {
            id                                  : v0,
            items                               : v1,
            first_item_is_from_previous_history : v2,
            length                              : v3,
            binary_length                       : v4,
            this_object_items_binary_length     : _,
            history                             : v6,
            history_items_count                 : v7,
            archive                             : v8,
            archive_items_count                 : v9,
            archived_at_length                  : _,
            archived_from_length                : _,
            burned_archive_count                : _,
            made_with_version                   : _,
            meta                                : _,
        } = arg1;
        let v15 = v6;
        let v16 = v1;
        if (v9 > 0) {
            abort 97
        };
        let v17 = arg0.length;
        let v18 = arg0.binary_length;
        if (0x1::vector::length<vector<u8>>(&arg0.items) > 0) {
            clamp(arg0, 0x1::option::none<vector<u8>>());
        };
        if (0x1::option::is_some<0x2::table::Table<u64, EndlessVectorHistory>>(&v15)) {
            let v19 = 0x1::option::destroy_some<0x2::table::Table<u64, EndlessVectorHistory>>(v15);
            let v20 = 0;
            while (v20 < v7) {
                let v21 = 0x2::table::remove<u64, EndlessVectorHistory>(&mut v19, v20);
                v21.saved_at_length = v21.saved_at_length + v17;
                if (0x1::option::is_none<0x2::table::Table<u64, EndlessVectorHistory>>(&arg0.history)) {
                    abort 99
                };
                0x2::table::add<u64, EndlessVectorHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessVectorHistory>>(&mut arg0.history), arg0.history_items_count, v21);
                arg0.history_items_count = arg0.history_items_count + 1;
                v20 = v20 + 1;
            };
            0x2::table::drop<u64, EndlessVectorHistory>(v19);
        } else {
            0x1::option::destroy_none<0x2::table::Table<u64, EndlessVectorHistory>>(v15);
        };
        let v22 = 0x1::vector::length<vector<u8>>(&v16);
        let v23 = 0;
        let v24 = 0;
        while (v23 < v22) {
            let v25 = 0x1::vector::borrow<vector<u8>>(&v16, v23);
            v24 = v24 + 0x1::vector::length<u8>(v25);
            0x1::vector::push_back<vector<u8>>(&mut arg0.items, *v25);
            v23 = v23 + 1;
        };
        arg0.this_object_items_binary_length = arg0.this_object_items_binary_length + v24;
        if (v2 && v22 > 0) {
            arg0.first_item_is_from_previous_history = true;
        };
        arg0.length = v17 + v3;
        arg0.binary_length = v18 + v4;
        0x2::table::destroy_empty<u64, EndlessVectorArchive>(v8);
        0x2::object::delete(v0);
    }

    public fun empty_and_push(arg0: vector<vector<u8>>, arg1: &mut 0x2::tx_context::TxContext) : EndlessVector {
        let v0 = empty(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v2 = &mut v0;
            push_back(v2, *0x1::vector::borrow<vector<u8>>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun empty_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = empty(arg0);
        0x2::transfer::transfer<EndlessVector>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun empty_entry_and_push(arg0: vector<vector<u8>>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = empty_and_push(arg0, arg1);
        0x2::transfer::transfer<EndlessVector>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun flush(arg0: &mut EndlessVector) {
        arg0.items = 0x1::vector::empty<vector<u8>>();
        arg0.first_item_is_from_previous_history = false;
        arg0.length = 0;
        arg0.binary_length = 0;
        arg0.this_object_items_binary_length = 0;
        while (arg0.history_items_count > 0) {
            0x2::table::remove<u64, EndlessVectorHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessVectorHistory>>(&mut arg0.history), arg0.history_items_count - 1);
            arg0.history_items_count = arg0.history_items_count - 1;
        };
        arg0.archived_at_length = 0;
        arg0.archived_from_length = 0;
        arg0.burned_archive_count = 0;
        while (arg0.archive_items_count > 0) {
            let EndlessVectorArchive {
                id                 : v0,
                history            : v1,
                archived_at_length : _,
                length             : _,
            } = 0x2::table::remove<u64, EndlessVectorArchive>(&mut arg0.archive, arg0.archive_items_count - 1);
            0x2::object::delete(v0);
            0x2::table::drop<u64, EndlessVectorHistory>(v1);
            arg0.archive_items_count = arg0.archive_items_count - 1;
        };
    }

    public fun get_at(arg0: &EndlessVector, arg1: u64) : vector<u8> {
        if (arg0.history_items_count == 0 && arg0.archive_items_count == 0) {
            return get_from_items(arg0, arg1)
        };
        let v0 = get_first_not_historied_index(arg0);
        if (arg1 < v0) {
            if (arg0.archived_at_length > arg1) {
                return get_from_archive(arg0, arg1)
            };
            return get_from_history(arg0, arg1)
        };
        if (arg0.first_item_is_from_previous_history) {
            return get_from_items(arg0, arg1 - v0 + 1)
        };
        get_from_items(arg0, arg1 - v0)
    }

    fun get_first_not_historied_index(arg0: &EndlessVector) : u64 {
        if (arg0.history_items_count == 0 && arg0.archive_items_count == 0) {
            return 0
        };
        if (arg0.first_item_is_from_previous_history) {
            return arg0.length - 0x1::vector::length<vector<u8>>(&arg0.items) - 1
        };
        arg0.length - 0x1::vector::length<vector<u8>>(&arg0.items)
    }

    fun get_from_archive(arg0: &EndlessVector, arg1: u64) : vector<u8> {
        if (arg0.burned_archive_count > 0 && arg1 < arg0.archived_from_length) {
            abort 92
        };
        let v0 = 0x2::table::borrow<u64, EndlessVectorArchive>(&arg0.archive, binary_search_archive_by_archived_length(arg0, arg1));
        let v1 = binary_search_archive_history_by_saved_length(v0, arg1);
        let v2 = 0x2::table::borrow<u64, EndlessVectorHistory>(&v0.history, v1);
        let v3 = arg1 + 0x1::vector::length<vector<u8>>(&v2.items) - v2.saved_at_length;
        if (v3 < 0x1::vector::length<vector<u8>>(&v2.items) - 1 || v2.followed_by_next_bytes == 0) {
            return *0x1::vector::borrow<vector<u8>>(&v2.items, v3)
        };
        let v4 = *0x1::vector::borrow<vector<u8>>(&v2.items, v3);
        assert!(v1 + 1 < 0x2::table::length<u64, EndlessVectorHistory>(&v0.history), 0);
        0x1::vector::append<u8>(&mut v4, *0x1::vector::borrow<vector<u8>>(&0x2::table::borrow<u64, EndlessVectorHistory>(&v0.history, v1 + 1).items, 0));
        v4
    }

    fun get_from_history(arg0: &EndlessVector, arg1: u64) : vector<u8> {
        let v0 = binary_search_history_by_saved_length(arg0, arg1);
        let v1 = 0x2::table::borrow<u64, EndlessVectorHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessVectorHistory>>(&arg0.history), v0);
        let v2 = arg1 + 0x1::vector::length<vector<u8>>(&v1.items) - v1.saved_at_length;
        if (v2 < 0x1::vector::length<vector<u8>>(&v1.items) - 1 || v1.followed_by_next_bytes == 0) {
            return *0x1::vector::borrow<vector<u8>>(&v1.items, v2)
        };
        let v3 = *0x1::vector::borrow<vector<u8>>(&v1.items, v2);
        let v4 = if (v0 + 1 < arg0.history_items_count) {
            *0x1::vector::borrow<vector<u8>>(&0x2::table::borrow<u64, EndlessVectorHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessVectorHistory>>(&arg0.history), v0 + 1).items, 0)
        } else {
            assert!(arg0.first_item_is_from_previous_history && 0x1::vector::length<vector<u8>>(&arg0.items) > 0, 0);
            *0x1::vector::borrow<vector<u8>>(&arg0.items, 0)
        };
        0x1::vector::append<u8>(&mut v3, v4);
        v3
    }

    fun get_from_items(arg0: &EndlessVector, arg1: u64) : vector<u8> {
        if (arg1 >= 0x1::vector::length<vector<u8>>(&arg0.items)) {
            abort 0
        };
        *0x1::vector::borrow<vector<u8>>(&arg0.items, arg1)
    }

    fun get_history_item_total_size(arg0: &EndlessVectorHistory) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0.items)) {
            v0 = v0 + 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg0.items, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun has_items_from(arg0: &EndlessVector) : u64 {
        arg0.archived_from_length
    }

    public fun size(arg0: &EndlessVector) : u64 {
        arg0.binary_length
    }

    public fun transfer_to_sender(arg0: EndlessVector, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<EndlessVector>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun update_at(arg0: &mut EndlessVector, arg1: u64, arg2: vector<u8>) {
        if (arg1 >= arg0.length) {
            abort 96
        };
        if (arg0.archived_at_length > arg1) {
            abort 93
        };
        if (arg0.history_items_count == 0 && arg0.archive_items_count == 0) {
            update_in_items(arg0, arg1, arg2);
            return
        };
        if (arg1 < get_first_not_historied_index(arg0)) {
            update_in_history(arg0, arg1, arg2);
        } else {
            update_in_items(arg0, arg1, arg2);
        };
    }

    fun update_in_history(arg0: &mut EndlessVector, arg1: u64, arg2: vector<u8>) {
        let v0 = binary_search_history_by_saved_length(arg0, arg1);
        let v1 = 0x2::table::borrow_mut<u64, EndlessVectorHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessVectorHistory>>(&mut arg0.history), v0);
        let v2 = arg1 + 0x1::vector::length<vector<u8>>(&v1.items) - v1.saved_at_length;
        if (v2 >= 0x1::vector::length<vector<u8>>(&v1.items)) {
            abort 96
        };
        if (v2 == 0x1::vector::length<vector<u8>>(&v1.items) - 1 && v1.followed_by_next_bytes > 0) {
            update_split_item_in_history(arg0, v0, arg2);
            return
        };
        if (v2 == 0 && v1.first_item_is_from_previous_history) {
            abort 95
        };
        let v3 = 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&v1.items, v2));
        let v4 = 0x1::vector::length<u8>(&arg2);
        if (v4 > v3) {
            if (get_history_item_total_size(v1) + v4 - v3 > 131072) {
                abort 94
            };
        };
        if (v4 > v3) {
            arg0.binary_length = arg0.binary_length + v4 - v3;
        } else if (v4 < v3) {
            arg0.binary_length = arg0.binary_length - v3 - v4;
        };
        *0x1::vector::borrow_mut<vector<u8>>(&mut v1.items, v2) = arg2;
    }

    fun update_in_items(arg0: &mut EndlessVector, arg1: u64, arg2: vector<u8>) {
        let v0 = if (arg0.first_item_is_from_previous_history) {
            arg1 - get_first_not_historied_index(arg0) + 1
        } else {
            arg1 - get_first_not_historied_index(arg0)
        };
        if (v0 >= 0x1::vector::length<vector<u8>>(&arg0.items)) {
            abort 96
        };
        if (v0 == 0 && arg0.first_item_is_from_previous_history) {
            abort 95
        };
        let v1 = 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg0.items, v0));
        let v2 = 0x1::vector::length<u8>(&arg2);
        if (v2 > v1) {
            let v3 = v2 - v1;
            if (arg0.this_object_items_binary_length + v3 > 131072) {
                abort 94
            };
            arg0.this_object_items_binary_length = arg0.this_object_items_binary_length + v3;
            arg0.binary_length = arg0.binary_length + v3;
        } else if (v2 < v1) {
            let v4 = v1 - v2;
            arg0.this_object_items_binary_length = arg0.this_object_items_binary_length - v4;
            arg0.binary_length = arg0.binary_length - v4;
        };
        *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.items, v0) = arg2;
    }

    fun update_split_item_in_history(arg0: &mut EndlessVector, arg1: u64, arg2: vector<u8>) {
        let v0 = 0x2::table::borrow<u64, EndlessVectorHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessVectorHistory>>(&arg0.history), arg1);
        let v1 = 0x1::vector::length<vector<u8>>(&v0.items) - 1;
        let v2 = 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&v0.items, v1));
        let v3 = v0.followed_by_next_bytes;
        let v4 = get_history_item_total_size(v0);
        let v5 = v2 + v3;
        let v6 = 0x1::vector::length<u8>(&arg2);
        if (v6 > v5) {
            arg0.binary_length = arg0.binary_length + v6 - v5;
        } else if (v6 < v5) {
            arg0.binary_length = arg0.binary_length - v5 - v6;
        };
        let v7 = arg1 + 1 < arg0.history_items_count;
        let v8 = arg0.first_item_is_from_previous_history && 0x1::vector::length<vector<u8>>(&arg0.items) > 0;
        if (!v7 && !v8) {
            abort 0
        };
        let v9 = if (v6 <= v2) {
            v6
        } else {
            v2
        };
        let v10 = 0x1::vector::empty<u8>();
        let v11 = 0x1::vector::empty<u8>();
        let v12 = 0;
        while (v12 < v6) {
            if (v12 < v9) {
                0x1::vector::push_back<u8>(&mut v10, *0x1::vector::borrow<u8>(&arg2, v12));
            } else {
                0x1::vector::push_back<u8>(&mut v11, *0x1::vector::borrow<u8>(&arg2, v12));
            };
            v12 = v12 + 1;
        };
        let v13 = 0x1::vector::length<u8>(&v11);
        if (v9 > v2) {
            if (v4 + v9 - v2 > 131072) {
                abort 94
            };
        };
        if (v7 && v13 > v3) {
            if (get_history_item_total_size(0x2::table::borrow<u64, EndlessVectorHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessVectorHistory>>(&arg0.history), arg1 + 1)) + v13 - v3 > 131072) {
                abort 94
            };
        };
        let v14 = 0x2::table::borrow_mut<u64, EndlessVectorHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessVectorHistory>>(&mut arg0.history), arg1);
        *0x1::vector::borrow_mut<vector<u8>>(&mut v14.items, v1) = v10;
        v14.followed_by_next_bytes = v13;
        if (v7) {
            if (v13 > 0) {
                *0x1::vector::borrow_mut<vector<u8>>(&mut 0x2::table::borrow_mut<u64, EndlessVectorHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessVectorHistory>>(&mut arg0.history), arg1 + 1).items, 0) = v11;
            } else {
                *0x1::vector::borrow_mut<vector<u8>>(&mut 0x2::table::borrow_mut<u64, EndlessVectorHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessVectorHistory>>(&mut arg0.history), arg1 + 1).items, 0) = 0x1::vector::empty<u8>();
            };
        } else if (v13 > 0) {
            if (v13 > v3) {
                if (arg0.this_object_items_binary_length + v13 - v3 > 131072) {
                    abort 94
                };
            };
            *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.items, 0) = v11;
            if (v13 > v3) {
                arg0.this_object_items_binary_length = arg0.this_object_items_binary_length - v3 + v13;
            } else if (v13 < v3) {
                arg0.this_object_items_binary_length = arg0.this_object_items_binary_length - v3 + v13;
            };
        } else {
            *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.items, 0) = 0x1::vector::empty<u8>();
            arg0.this_object_items_binary_length = arg0.this_object_items_binary_length - v3;
        };
    }

    // decompiled from Move bytecode v6
}

