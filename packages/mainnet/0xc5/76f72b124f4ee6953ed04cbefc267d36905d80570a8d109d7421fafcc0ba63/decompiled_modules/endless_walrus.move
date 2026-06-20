module 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus {
    struct EndlessWalrusVector has store, key {
        id: 0x2::object::UID,
        items: vector<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>,
        first_item_is_from_previous_history: bool,
        length: u64,
        binary_length: u64,
        this_object_items_binary_length: u64,
        this_object_storage_volume: u64,
        history: 0x1::option::Option<0x2::table::Table<u64, EndlessWalrusHistory>>,
        history_items_count: u64,
        archive: 0x2::table::Table<u64, EndlessWalrusArchive>,
        archive_items_count: u64,
        archived_at_length: u64,
        archived_from_length: u64,
        burned_archive_count: u64,
        made_with_version: u64,
        meta: vector<u8>,
        seal_encrypted_key: 0x1::option::Option<vector<u8>>,
    }

    struct EndlessWalrusHistory has store {
        items: vector<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>,
        followed_by_next_bytes: u64,
        first_item_is_from_previous_history: bool,
        saved_at_length: u64,
        storage_volume: u64,
    }

    struct EndlessWalrusArchive has store, key {
        id: 0x2::object::UID,
        history: 0x2::table::Table<u64, EndlessWalrusHistory>,
        archived_at_length: u64,
        length: u64,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : EndlessWalrusVector {
        EndlessWalrusVector{
            id                                  : 0x2::object::new(arg0),
            items                               : 0x1::vector::empty<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(),
            first_item_is_from_previous_history : false,
            length                              : 0,
            binary_length                       : 0,
            this_object_items_binary_length     : 0,
            this_object_storage_volume          : 0,
            history                             : 0x1::option::some<0x2::table::Table<u64, EndlessWalrusHistory>>(0x2::table::new<u64, EndlessWalrusHistory>(arg0)),
            history_items_count                 : 0,
            archive                             : 0x2::table::new<u64, EndlessWalrusArchive>(arg0),
            archive_items_count                 : 0,
            archived_at_length                  : 0,
            archived_from_length                : 0,
            burned_archive_count                : 0,
            made_with_version                   : 3,
            meta                                : 0x1::vector::empty<u8>(),
            seal_encrypted_key                  : 0x1::option::none<vector<u8>>(),
        }
    }

    public fun length(arg0: &EndlessWalrusVector) : u64 {
        arg0.length
    }

    public fun push_back(arg0: &mut EndlessWalrusVector, arg1: 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem) {
        let v0 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_storage_volume(&arg1);
        let v1 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_binary_length(&arg1);
        if (v0 > 131072) {
            abort 91
        };
        if (v0 + arg0.this_object_storage_volume > 131072) {
            clamp(arg0, 0x1::option::some<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg1));
        } else {
            0x1::vector::push_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg0.items, arg1);
            arg0.this_object_storage_volume = arg0.this_object_storage_volume + v0;
            arg0.this_object_items_binary_length = arg0.this_object_items_binary_length + v1;
            arg0.binary_length = arg0.binary_length + v1;
            arg0.length = arg0.length + 1;
        };
    }

    public fun append(arg0: &mut EndlessWalrusVector, arg1: vector<EndlessWalrusVector>) {
        0x1::vector::reverse<EndlessWalrusVector>(&mut arg1);
        while (!0x1::vector::is_empty<EndlessWalrusVector>(&arg1)) {
            concat(arg0, 0x1::vector::pop_back<EndlessWalrusVector>(&mut arg1));
        };
        0x1::vector::destroy_empty<EndlessWalrusVector>(arg1);
    }

    public fun archive(arg0: &mut EndlessWalrusVector, arg1: &mut 0x2::tx_context::TxContext) {
        clamp(arg0, 0x1::option::none<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>());
        let v0 = EndlessWalrusArchive{
            id                 : 0x2::object::new(arg1),
            history            : 0x1::option::swap<0x2::table::Table<u64, EndlessWalrusHistory>>(&mut arg0.history, 0x2::table::new<u64, EndlessWalrusHistory>(arg1)),
            archived_at_length : arg0.length,
            length             : arg0.length - arg0.archived_at_length,
        };
        0x2::table::add<u64, EndlessWalrusArchive>(&mut arg0.archive, arg0.archive_items_count, v0);
        arg0.archive_items_count = arg0.archive_items_count + 1;
        arg0.history_items_count = 0;
        arg0.archived_at_length = arg0.length;
    }

    public fun archive_items_count(arg0: &EndlessWalrusVector) : u64 {
        arg0.archive_items_count
    }

    fun binary_search_archive_by_archived_length(arg0: &EndlessWalrusVector, arg1: u64) : u64 {
        if (arg0.archive_items_count == 0) {
            abort 0
        } else {
            let v0 = arg0.burned_archive_count;
            let v1 = arg0.archive_items_count - 1;
            while (v0 <= v1) {
                let v2 = v0 + (v1 - v0) / 2;
                let v3 = 0x2::table::borrow<u64, EndlessWalrusArchive>(&arg0.archive, v2);
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

    fun binary_search_archive_history_by_saved_length(arg0: &EndlessWalrusArchive, arg1: u64) : u64 {
        let v0 = 0x2::table::length<u64, EndlessWalrusHistory>(&arg0.history);
        if (v0 == 0) {
            abort 0
        } else {
            let v1 = 0;
            let v2 = v0 - 1;
            while (v1 <= v2) {
                let v3 = v1 + (v2 - v1) / 2;
                let v4 = 0x2::table::borrow<u64, EndlessWalrusHistory>(&arg0.history, v3);
                if (arg1 < v4.saved_at_length) {
                    if (v3 == 0) {
                        return v3
                    };
                    let v5 = if (v4.first_item_is_from_previous_history) {
                        v4.saved_at_length - 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v4.items) + 1
                    } else {
                        v4.saved_at_length - 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v4.items)
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

    fun binary_search_history_by_saved_length(arg0: &EndlessWalrusVector, arg1: u64) : u64 {
        if (arg0.history_items_count == 0) {
            return 0
        };
        let v0 = 0;
        let v1 = arg0.history_items_count - 1;
        while (v0 <= v1) {
            let v2 = v0 + (v1 - v0) / 2;
            let v3 = 0x2::table::borrow<u64, EndlessWalrusHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history), v2);
            if (arg1 < v3.saved_at_length) {
                if (v2 == 0) {
                    return v2
                };
                let v4 = if (v3.first_item_is_from_previous_history) {
                    v3.saved_at_length - 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v3.items) + 1
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

    fun blob_extend_cost(arg0: &0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem, arg1: u32, arg2: u32, arg3: u64) : u64 {
        if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_blob(arg0)) {
            return 0
        };
        let v0 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_blob(arg0);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v0);
        if (v1 >= arg2 || arg1 >= v1) {
            return 0
        };
        (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(v0)) + 1048576 - 1) / 1048576 * arg3 * ((arg2 - v1) as u64)
    }

    public fun borrow_blob_at(arg0: &EndlessWalrusVector, arg1: u64) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        let v0 = get_at(arg0, arg1);
        if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_blob(v0)) {
            abort 101
        };
        0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_blob(v0)
    }

    public fun burn(arg0: EndlessWalrusVector) {
        let v0 = &mut arg0;
        flush(v0);
        let EndlessWalrusVector {
            id                                  : v1,
            items                               : v2,
            first_item_is_from_previous_history : _,
            length                              : _,
            binary_length                       : _,
            this_object_items_binary_length     : _,
            this_object_storage_volume          : _,
            history                             : v8,
            history_items_count                 : _,
            archive                             : v10,
            archive_items_count                 : _,
            archived_at_length                  : _,
            archived_from_length                : _,
            burned_archive_count                : _,
            made_with_version                   : _,
            meta                                : _,
            seal_encrypted_key                  : _,
        } = arg0;
        let v18 = v8;
        0x1::vector::destroy_empty<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(v2);
        if (0x1::option::is_some<0x2::table::Table<u64, EndlessWalrusHistory>>(&v18)) {
            0x2::table::destroy_empty<u64, EndlessWalrusHistory>(0x1::option::destroy_some<0x2::table::Table<u64, EndlessWalrusHistory>>(v18));
        } else {
            0x1::option::destroy_none<0x2::table::Table<u64, EndlessWalrusHistory>>(v18);
        };
        0x2::table::destroy_empty<u64, EndlessWalrusArchive>(v10);
        0x2::object::delete(v1);
    }

    public fun burn_archive(arg0: &mut EndlessWalrusVector) {
        if (arg0.archive_items_count > 0) {
            let v0 = 0x2::table::remove<u64, EndlessWalrusArchive>(&mut arg0.archive, arg0.burned_archive_count);
            burn_archive_item(v0);
            arg0.burned_archive_count = arg0.burned_archive_count + 1;
            arg0.archived_from_length = arg0.archived_from_length + v0.length;
        };
    }

    fun burn_archive_item(arg0: EndlessWalrusArchive) {
        let EndlessWalrusArchive {
            id                 : v0,
            history            : v1,
            archived_at_length : _,
            length             : _,
        } = arg0;
        let v4 = v1;
        let v5 = 0;
        while (v5 < 0x2::table::length<u64, EndlessWalrusHistory>(&v4)) {
            burn_history_segment(0x2::table::remove<u64, EndlessWalrusHistory>(&mut v4, v5));
            v5 = v5 + 1;
        };
        0x2::table::destroy_empty<u64, EndlessWalrusHistory>(v4);
        0x2::object::delete(v0);
    }

    fun burn_history_segment(arg0: EndlessWalrusHistory) {
        let EndlessWalrusHistory {
            items                               : v0,
            followed_by_next_bytes              : _,
            first_item_is_from_previous_history : _,
            saved_at_length                     : _,
            storage_volume                      : _,
        } = arg0;
        burn_items_vec(v0);
    }

    fun burn_items_vec(arg0: vector<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>) {
        while (!0x1::vector::is_empty<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0)) {
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(0x1::vector::pop_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg0));
        };
        0x1::vector::destroy_empty<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0);
    }

    public fun clamp(arg0: &mut EndlessWalrusVector, arg1: 0x1::option::Option<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>) {
        0x1::vector::reverse<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg0.items);
        let v0 = 0x1::vector::empty<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>();
        while (!0x1::vector::is_empty<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items)) {
            0x1::vector::push_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut v0, 0x1::vector::pop_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg0.items));
        };
        let v1 = arg0.this_object_storage_volume;
        let v2 = EndlessWalrusHistory{
            items                               : v0,
            followed_by_next_bytes              : 0,
            first_item_is_from_previous_history : arg0.first_item_is_from_previous_history,
            saved_at_length                     : arg0.length,
            storage_volume                      : v1,
        };
        arg0.first_item_is_from_previous_history = false;
        if (0x1::option::is_some<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg1)) {
            let v3 = 0x1::option::destroy_some<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg1);
            if (0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_is_empty(&v3)) {
                0x1::vector::push_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg0.items, v3);
                arg0.this_object_storage_volume = 0;
                arg0.this_object_items_binary_length = 0;
                arg0.length = arg0.length + 1;
                v2.saved_at_length = arg0.length;
            } else if (0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_blob(&v3)) {
                let v4 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_binary_length(&v3);
                arg0.binary_length = arg0.binary_length + v4;
                0x1::vector::push_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg0.items, v3);
                arg0.this_object_storage_volume = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_storage_volume(&v3);
                arg0.this_object_items_binary_length = v4;
                arg0.length = arg0.length + 1;
                v2.saved_at_length = arg0.length;
            } else {
                let v5 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::destroy_item_into_bytes(v3);
                arg0.binary_length = arg0.binary_length + 0x1::vector::length<u8>(&v5);
                let v6 = 131072 - v1;
                if (0x1::vector::length<u8>(&v5) <= v6) {
                    0x1::vector::push_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut v2.items, 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::new_bytes_item(v5));
                    v2.followed_by_next_bytes = 0;
                    v2.storage_volume = v2.storage_volume + 0x1::vector::length<u8>(&v5);
                    arg0.this_object_storage_volume = 0;
                    arg0.this_object_items_binary_length = 0;
                    arg0.length = arg0.length + 1;
                    v2.saved_at_length = arg0.length;
                } else {
                    let v7 = 0x1::vector::length<u8>(&v5) - v6;
                    let v8 = 0x1::vector::empty<u8>();
                    while (v7 > 0) {
                        0x1::vector::push_back<u8>(&mut v8, 0x1::vector::pop_back<u8>(&mut v5));
                        v7 = v7 - 1;
                    };
                    0x1::vector::reverse<u8>(&mut v8);
                    0x1::vector::push_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut v2.items, 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::new_bytes_item(v5));
                    v2.followed_by_next_bytes = 0x1::vector::length<u8>(&v8);
                    v2.storage_volume = v2.storage_volume + 0x1::vector::length<u8>(&v5);
                    let v9 = 0x1::vector::length<u8>(&v8);
                    arg0.this_object_storage_volume = v9;
                    arg0.this_object_items_binary_length = v9;
                    if (v9 > 0) {
                        0x1::vector::push_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg0.items, 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::new_bytes_item(v8));
                        arg0.first_item_is_from_previous_history = true;
                        arg0.length = arg0.length + 1;
                    } else {
                        0x1::vector::destroy_empty<u8>(v8);
                        arg0.length = arg0.length + 1;
                    };
                    v2.saved_at_length = arg0.length;
                };
            };
        } else {
            0x1::option::destroy_none<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg1);
            arg0.this_object_storage_volume = 0;
            arg0.this_object_items_binary_length = 0;
        };
        0x2::table::add<u64, EndlessWalrusHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessWalrusHistory>>(&mut arg0.history), arg0.history_items_count, v2);
        arg0.history_items_count = arg0.history_items_count + 1;
    }

    public fun compose_and_push_back(arg0: &mut EndlessWalrusVector, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>) {
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
        push_back_bytes(arg0, v0);
    }

    public fun concat(arg0: &mut EndlessWalrusVector, arg1: EndlessWalrusVector) {
        assert!(0x1::option::is_none<vector<u8>>(&arg0.seal_encrypted_key), 104);
        assert!(0x1::option::is_none<vector<u8>>(&arg1.seal_encrypted_key), 104);
        let EndlessWalrusVector {
            id                                  : v0,
            items                               : v1,
            first_item_is_from_previous_history : v2,
            length                              : v3,
            binary_length                       : v4,
            this_object_items_binary_length     : _,
            this_object_storage_volume          : _,
            history                             : v7,
            history_items_count                 : v8,
            archive                             : v9,
            archive_items_count                 : v10,
            archived_at_length                  : _,
            archived_from_length                : _,
            burned_archive_count                : _,
            made_with_version                   : _,
            meta                                : _,
            seal_encrypted_key                  : _,
        } = arg1;
        let v17 = v7;
        let v18 = v1;
        if (v10 > 0) {
            abort 97
        };
        let v19 = arg0.length;
        let v20 = arg0.binary_length;
        if (0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items) > 0) {
            clamp(arg0, 0x1::option::none<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>());
        };
        if (0x1::option::is_some<0x2::table::Table<u64, EndlessWalrusHistory>>(&v17)) {
            let v21 = 0x1::option::destroy_some<0x2::table::Table<u64, EndlessWalrusHistory>>(v17);
            let v22 = 0;
            while (v22 < v8) {
                let v23 = 0x2::table::remove<u64, EndlessWalrusHistory>(&mut v21, v22);
                v23.saved_at_length = v23.saved_at_length + v19;
                if (0x1::option::is_none<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history)) {
                    abort 99
                };
                0x2::table::add<u64, EndlessWalrusHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessWalrusHistory>>(&mut arg0.history), arg0.history_items_count, v23);
                arg0.history_items_count = arg0.history_items_count + 1;
                v22 = v22 + 1;
            };
            0x2::table::destroy_empty<u64, EndlessWalrusHistory>(v21);
        } else {
            0x1::option::destroy_none<0x2::table::Table<u64, EndlessWalrusHistory>>(v17);
        };
        let v24 = 0;
        let v25 = 0;
        let v26 = 0;
        let v27 = 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v18);
        while (v26 < v27) {
            let v28 = 0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v18, v26);
            v24 = v24 + 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_storage_volume(v28);
            v25 = v25 + 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_binary_length(v28);
            v26 = v26 + 1;
        };
        let v29 = &mut arg0.items;
        drain_items_into(v29, v18);
        arg0.this_object_storage_volume = arg0.this_object_storage_volume + v24;
        arg0.this_object_items_binary_length = arg0.this_object_items_binary_length + v25;
        if (v2 && v27 > 0) {
            arg0.first_item_is_from_previous_history = true;
        };
        arg0.length = v19 + v3;
        arg0.binary_length = v20 + v4;
        0x2::table::destroy_empty<u64, EndlessWalrusArchive>(v9);
        0x2::object::delete(v0);
    }

    fun drain_items_into(arg0: &mut vector<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>, arg1: vector<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>) {
        0x1::vector::reverse<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg1);
        while (!0x1::vector::is_empty<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg1)) {
            0x1::vector::push_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0, 0x1::vector::pop_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg1));
        };
        0x1::vector::destroy_empty<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg1);
    }

    public fun empty_and_push(arg0: vector<vector<u8>>, arg1: &mut 0x2::tx_context::TxContext) : EndlessWalrusVector {
        let v0 = empty(arg1);
        0x1::vector::reverse<vector<u8>>(&mut arg0);
        while (!0x1::vector::is_empty<vector<u8>>(&arg0)) {
            let v1 = &mut v0;
            push_back_bytes(v1, 0x1::vector::pop_back<vector<u8>>(&mut arg0));
        };
        0x1::vector::destroy_empty<vector<u8>>(arg0);
        v0
    }

    public fun empty_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = empty(arg0);
        0x2::transfer::transfer<EndlessWalrusVector>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun empty_entry_and_push(arg0: vector<vector<u8>>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = empty_and_push(arg0, arg1);
        0x2::transfer::transfer<EndlessWalrusVector>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun ensure_length(arg0: &EndlessWalrusVector, arg1: u64) {
        assert!(arg0.length == arg1, 98);
    }

    public fun extend_blobs_cost_to_epoch(arg0: &EndlessWalrusVector, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: u64) : u64 {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        let v1 = 0;
        let v2 = &mut v1;
        fold_extend_cost_over_items(&arg0.items, v0, arg2, arg3, v2);
        if (0x1::option::is_some<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history)) {
            let v3 = 0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history);
            let v4 = 0;
            while (v4 < arg0.history_items_count) {
                let v5 = &mut v1;
                fold_extend_cost_over_items(&0x2::table::borrow<u64, EndlessWalrusHistory>(v3, v4).items, v0, arg2, arg3, v5);
                v4 = v4 + 1;
            };
        };
        let v6 = arg0.burned_archive_count;
        while (v6 < arg0.archive_items_count) {
            let v7 = 0x2::table::borrow<u64, EndlessWalrusArchive>(&arg0.archive, v6);
            let v8 = 0;
            while (v8 < 0x2::table::length<u64, EndlessWalrusHistory>(&v7.history)) {
                let v9 = &mut v1;
                fold_extend_cost_over_items(&0x2::table::borrow<u64, EndlessWalrusHistory>(&v7.history, v8).items, v0, arg2, arg3, v9);
                v8 = v8 + 1;
            };
            v6 = v6 + 1;
        };
        v1 + v1 * 2000 / 10000
    }

    public fun extend_blobs_to_epoch(arg0: &mut EndlessWalrusVector, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        let v1 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3);
        let v2 = &mut arg0.items;
        extend_items_to_epoch(v2, arg1, v0, arg2, arg3);
        if (0x1::option::is_some<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history)) {
            let v3 = 0;
            while (v3 < arg0.history_items_count) {
                let v4 = &mut 0x2::table::borrow_mut<u64, EndlessWalrusHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessWalrusHistory>>(&mut arg0.history), v3).items;
                extend_items_to_epoch(v4, arg1, v0, arg2, arg3);
                v3 = v3 + 1;
            };
        };
        let v5 = arg0.burned_archive_count;
        while (v5 < arg0.archive_items_count) {
            let v6 = 0x2::table::borrow_mut<u64, EndlessWalrusArchive>(&mut arg0.archive, v5);
            let v7 = 0;
            while (v7 < 0x2::table::length<u64, EndlessWalrusHistory>(&v6.history)) {
                let v8 = &mut 0x2::table::borrow_mut<u64, EndlessWalrusHistory>(&mut v6.history, v7).items;
                extend_items_to_epoch(v8, arg1, v0, arg2, arg3);
                v7 = v7 + 1;
            };
            v5 = v5 + 1;
        };
        let v9 = (v1 - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3)) * 2000 / 10000;
        if (v9 > 0 && 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3) >= v9) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3, v9, arg4), @0x1b8472b728af3c2ce1d1e2e1d3289b64758a7498a02f089a8569260d81485f32);
        };
    }

    public entry fun extend_blobs_to_epoch_entry(arg0: &mut EndlessWalrusVector, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) {
        extend_blobs_to_epoch(arg0, arg1, arg2, arg3, arg4);
    }

    fun extend_items_to_epoch(arg0: &mut vector<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: u32, arg4: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0, v0);
            if (0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_blob(v1)) {
                let v2 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_blob_mut(v1);
                let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v2);
                if (v3 < arg3 && arg2 < v3) {
                    0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, v2, arg3 - v3, arg4);
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun extension_fee_bps() : u64 {
        2000
    }

    public fun flush(arg0: &mut EndlessWalrusVector) {
        while (!0x1::vector::is_empty<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items)) {
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(0x1::vector::pop_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&mut arg0.items));
        };
        arg0.first_item_is_from_previous_history = false;
        arg0.length = 0;
        arg0.binary_length = 0;
        arg0.this_object_items_binary_length = 0;
        arg0.this_object_storage_volume = 0;
        while (arg0.history_items_count > 0) {
            burn_history_segment(0x2::table::remove<u64, EndlessWalrusHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessWalrusHistory>>(&mut arg0.history), arg0.history_items_count - 1));
            arg0.history_items_count = arg0.history_items_count - 1;
        };
        arg0.archived_at_length = 0;
        arg0.archived_from_length = 0;
        arg0.burned_archive_count = 0;
        while (arg0.archive_items_count > 0) {
            burn_archive_item(0x2::table::remove<u64, EndlessWalrusArchive>(&mut arg0.archive, arg0.archive_items_count - 1));
            arg0.archive_items_count = arg0.archive_items_count - 1;
        };
    }

    fun fold_extend_cost_over_items(arg0: &vector<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>, arg1: u32, arg2: u32, arg3: u64, arg4: &mut u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0)) {
            *arg4 = *arg4 + blob_extend_cost(0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0, v0), arg1, arg2, arg3);
            v0 = v0 + 1;
        };
    }

    fun fold_min_blob_end_epoch(arg0: &vector<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>, arg1: &mut 0x1::option::Option<u32>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0)) {
            let v1 = 0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0, v0);
            if (0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_blob(v1)) {
                let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_blob(v1));
                if (0x1::option::is_none<u32>(arg1) || v2 < *0x1::option::borrow<u32>(arg1)) {
                    *arg1 = 0x1::option::some<u32>(v2);
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun get_at(arg0: &EndlessWalrusVector, arg1: u64) : &0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem {
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

    fun get_first_not_historied_index(arg0: &EndlessWalrusVector) : u64 {
        if (arg0.history_items_count == 0 && arg0.archive_items_count == 0) {
            return 0
        };
        if (arg0.first_item_is_from_previous_history) {
            return arg0.length - 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items) - 1
        };
        arg0.length - 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items)
    }

    fun get_from_archive(arg0: &EndlessWalrusVector, arg1: u64) : &0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem {
        if (arg0.burned_archive_count > 0 && arg1 < arg0.archived_from_length) {
            abort 92
        };
        let v0 = 0x2::table::borrow<u64, EndlessWalrusArchive>(&arg0.archive, binary_search_archive_by_archived_length(arg0, arg1));
        let v1 = 0x2::table::borrow<u64, EndlessWalrusHistory>(&v0.history, binary_search_archive_history_by_saved_length(v0, arg1));
        0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v1.items, arg1 + 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v1.items) - v1.saved_at_length)
    }

    fun get_from_history(arg0: &EndlessWalrusVector, arg1: u64) : &0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem {
        let v0 = 0x2::table::borrow<u64, EndlessWalrusHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history), binary_search_history_by_saved_length(arg0, arg1));
        0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v0.items, arg1 + 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v0.items) - v0.saved_at_length)
    }

    fun get_from_items(arg0: &EndlessWalrusVector, arg1: u64) : &0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem {
        if (arg1 >= 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items)) {
            abort 0
        };
        0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items, arg1)
    }

    public fun has_items_from(arg0: &EndlessWalrusVector) : u64 {
        arg0.archived_from_length
    }

    public fun history_items_count(arg0: &EndlessWalrusVector) : u64 {
        arg0.history_items_count
    }

    public fun is_sealed(arg0: &EndlessWalrusVector) : bool {
        0x1::option::is_some<vector<u8>>(&arg0.seal_encrypted_key)
    }

    public fun min_blob_end_epoch(arg0: &EndlessWalrusVector) : 0x1::option::Option<u32> {
        let v0 = 0x1::option::none<u32>();
        let v1 = &mut v0;
        fold_min_blob_end_epoch(&arg0.items, v1);
        if (0x1::option::is_some<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history)) {
            let v2 = 0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history);
            let v3 = 0;
            while (v3 < arg0.history_items_count) {
                let v4 = &mut v0;
                fold_min_blob_end_epoch(&0x2::table::borrow<u64, EndlessWalrusHistory>(v2, v3).items, v4);
                v3 = v3 + 1;
            };
        };
        let v5 = arg0.burned_archive_count;
        while (v5 < arg0.archive_items_count) {
            let v6 = 0x2::table::borrow<u64, EndlessWalrusArchive>(&arg0.archive, v5);
            let v7 = 0;
            while (v7 < 0x2::table::length<u64, EndlessWalrusHistory>(&v6.history)) {
                let v8 = &mut v0;
                fold_min_blob_end_epoch(&0x2::table::borrow<u64, EndlessWalrusHistory>(&v6.history, v7).items, v8);
                v7 = v7 + 1;
            };
            v5 = v5 + 1;
        };
        v0
    }

    public fun push_back_blob(arg0: &mut EndlessWalrusVector, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob) {
        push_back(arg0, 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::new_blob_item(arg1));
    }

    public fun push_back_bytes(arg0: &mut EndlessWalrusVector, arg1: vector<u8>) {
        push_back(arg0, 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::new_bytes_item(arg1));
    }

    public fun read_bytes_at(arg0: &EndlessWalrusVector, arg1: u64) : vector<u8> {
        if (arg0.history_items_count == 0 && arg0.archive_items_count == 0) {
            let v0 = get_from_items(arg0, arg1);
            if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_bytes(v0)) {
                abort 100
            };
            return *0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_bytes(v0)
        };
        let v1 = get_first_not_historied_index(arg0);
        if (arg1 < v1) {
            if (arg0.archived_at_length > arg1) {
                return read_bytes_from_archive(arg0, arg1)
            };
            return read_bytes_from_history(arg0, arg1)
        };
        let v2 = if (arg0.first_item_is_from_previous_history) {
            arg1 - v1 + 1
        } else {
            arg1 - v1
        };
        let v3 = get_from_items(arg0, v2);
        if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_bytes(v3)) {
            abort 100
        };
        *0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_bytes(v3)
    }

    fun read_bytes_from_archive(arg0: &EndlessWalrusVector, arg1: u64) : vector<u8> {
        if (arg0.burned_archive_count > 0 && arg1 < arg0.archived_from_length) {
            abort 92
        };
        let v0 = 0x2::table::borrow<u64, EndlessWalrusArchive>(&arg0.archive, binary_search_archive_by_archived_length(arg0, arg1));
        let v1 = binary_search_archive_history_by_saved_length(v0, arg1);
        let v2 = 0x2::table::borrow<u64, EndlessWalrusHistory>(&v0.history, v1);
        let v3 = arg1 + 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v2.items) - v2.saved_at_length;
        let v4 = 0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v2.items, v3);
        if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_bytes(v4)) {
            abort 100
        };
        if (v3 < 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v2.items) - 1 || v2.followed_by_next_bytes == 0) {
            return *0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_bytes(v4)
        };
        let v5 = *0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_bytes(v4);
        assert!(v1 + 1 < 0x2::table::length<u64, EndlessWalrusHistory>(&v0.history), 0);
        let v6 = 0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&0x2::table::borrow<u64, EndlessWalrusHistory>(&v0.history, v1 + 1).items, 0);
        if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_bytes(v6)) {
            abort 100
        };
        0x1::vector::append<u8>(&mut v5, *0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_bytes(v6));
        v5
    }

    fun read_bytes_from_history(arg0: &EndlessWalrusVector, arg1: u64) : vector<u8> {
        let v0 = binary_search_history_by_saved_length(arg0, arg1);
        let v1 = 0x2::table::borrow<u64, EndlessWalrusHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history), v0);
        let v2 = arg1 + 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v1.items) - v1.saved_at_length;
        let v3 = 0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v1.items, v2);
        if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_bytes(v3)) {
            abort 100
        };
        if (v2 < 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v1.items) - 1 || v1.followed_by_next_bytes == 0) {
            return *0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_bytes(v3)
        };
        let v4 = *0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_bytes(v3);
        if (v0 + 1 < arg0.history_items_count) {
            let v5 = 0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&0x2::table::borrow<u64, EndlessWalrusHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history), v0 + 1).items, 0);
            if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_bytes(v5)) {
                abort 100
            };
            0x1::vector::append<u8>(&mut v4, *0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_bytes(v5));
        } else {
            assert!(arg0.first_item_is_from_previous_history && 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items) > 0, 0);
            let v6 = 0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items, 0);
            if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_bytes(v6)) {
                abort 100
            };
            0x1::vector::append<u8>(&mut v4, *0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_borrow_bytes(v6));
        };
        v4
    }

    public fun seal_approve_endless_vector_owner(arg0: vector<u8>, arg1: &EndlessWalrusVector, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_bytes(&arg1.id) == arg0, 102);
    }

    public fun seal_encrypted_key(arg0: &EndlessWalrusVector) : &0x1::option::Option<vector<u8>> {
        &arg0.seal_encrypted_key
    }

    public fun set_seal_encrypted_key(arg0: &mut EndlessWalrusVector, arg1: vector<u8>) {
        assert!(0x1::option::is_none<vector<u8>>(&arg0.seal_encrypted_key), 103);
        arg0.seal_encrypted_key = 0x1::option::some<vector<u8>>(arg1);
    }

    public fun size(arg0: &EndlessWalrusVector) : u64 {
        arg0.binary_length
    }

    fun swap_item_in_vec(arg0: &mut vector<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>, arg1: u64, arg2: 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem) : 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem {
        0x1::vector::push_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0, arg2);
        0x1::vector::swap<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0, arg1, 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0));
        0x1::vector::pop_back<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(arg0)
    }

    public fun transfer_to_sender(arg0: EndlessWalrusVector, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<EndlessWalrusVector>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun update_at(arg0: &mut EndlessWalrusVector, arg1: u64, arg2: 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem) {
        if (arg1 >= arg0.length) {
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(arg2);
            abort 96
        };
        if (arg0.archived_at_length > arg1) {
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(arg2);
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

    public fun update_bytes_at(arg0: &mut EndlessWalrusVector, arg1: u64, arg2: vector<u8>) {
        update_at(arg0, arg1, 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::new_bytes_item(arg2));
    }

    fun update_in_history(arg0: &mut EndlessWalrusVector, arg1: u64, arg2: 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem) {
        let v0 = binary_search_history_by_saved_length(arg0, arg1);
        let v1 = 0x2::table::borrow<u64, EndlessWalrusHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history), v0);
        let v2 = arg1 + 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v1.items) - v1.saved_at_length;
        let v3 = 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v1.items);
        if (v2 >= v3) {
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(arg2);
            abort 96
        };
        if (v2 == v3 - 1 && v1.followed_by_next_bytes > 0) {
            update_split_item_in_history(arg0, v0, arg2);
            return
        };
        if (v2 == 0 && v1.first_item_is_from_previous_history) {
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(arg2);
            abort 95
        };
        let v4 = 0x2::table::borrow<u64, EndlessWalrusHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history), v0);
        let v5 = 0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v4.items, v2);
        let v6 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_storage_volume(v5);
        let v7 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_binary_length(v5);
        let v8 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_storage_volume(&arg2);
        let v9 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_binary_length(&arg2);
        if (v8 > v6) {
            if (v4.storage_volume + v8 - v6 > 131072) {
                0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(arg2);
                abort 94
            };
        };
        if (v9 > v7) {
            arg0.binary_length = arg0.binary_length + v9 - v7;
        } else if (v9 < v7) {
            arg0.binary_length = arg0.binary_length - v7 - v9;
        };
        let v10 = 0x2::table::borrow_mut<u64, EndlessWalrusHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessWalrusHistory>>(&mut arg0.history), v0);
        let v11 = &mut v10.items;
        if (v8 > v6) {
            v10.storage_volume = v10.storage_volume + v8 - v6;
        } else if (v8 < v6) {
            v10.storage_volume = v10.storage_volume - v6 - v8;
        };
        0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(swap_item_in_vec(v11, v2, arg2));
    }

    fun update_in_items(arg0: &mut EndlessWalrusVector, arg1: u64, arg2: 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem) {
        let v0 = if (arg0.first_item_is_from_previous_history) {
            arg1 - get_first_not_historied_index(arg0) + 1
        } else {
            arg1 - get_first_not_historied_index(arg0)
        };
        if (v0 >= 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items)) {
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(arg2);
            abort 96
        };
        if (v0 == 0 && arg0.first_item_is_from_previous_history) {
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(arg2);
            abort 95
        };
        let v1 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_storage_volume(0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items, v0));
        let v2 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_binary_length(0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items, v0));
        let v3 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_storage_volume(&arg2);
        let v4 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_binary_length(&arg2);
        if (v3 > v1) {
            let v5 = v3 - v1;
            if (arg0.this_object_storage_volume + v5 > 131072) {
                0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(arg2);
                abort 94
            };
            arg0.this_object_storage_volume = arg0.this_object_storage_volume + v5;
        } else if (v3 < v1) {
            arg0.this_object_storage_volume = arg0.this_object_storage_volume - v1 - v3;
        };
        if (v4 > v2) {
            arg0.binary_length = arg0.binary_length + v4 - v2;
            arg0.this_object_items_binary_length = arg0.this_object_items_binary_length + v4 - v2;
        } else if (v4 < v2) {
            arg0.binary_length = arg0.binary_length - v2 - v4;
            arg0.this_object_items_binary_length = arg0.this_object_items_binary_length - v2 - v4;
        };
        let v6 = &mut arg0.items;
        0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(swap_item_in_vec(v6, v0, arg2));
    }

    fun update_split_item_in_history(arg0: &mut EndlessWalrusVector, arg1: u64, arg2: 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem) {
        if (!0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_has_bytes(&arg2)) {
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(arg2);
            abort 95
        };
        let v0 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::destroy_item_into_bytes(arg2);
        let v1 = 0x2::table::borrow<u64, EndlessWalrusHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history), arg1);
        let v2 = 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v1.items) - 1;
        let v3 = 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::item_storage_volume(0x1::vector::borrow<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&v1.items, v2));
        let v4 = v1.followed_by_next_bytes;
        let v5 = v1.storage_volume;
        let v6 = v3 + v4;
        let v7 = 0x1::vector::length<u8>(&v0);
        if (v7 > v6) {
            arg0.binary_length = arg0.binary_length + v7 - v6;
        } else if (v7 < v6) {
            arg0.binary_length = arg0.binary_length - v6 - v7;
        };
        let v8 = arg1 + 1 < arg0.history_items_count;
        let v9 = arg0.first_item_is_from_previous_history && 0x1::vector::length<0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::EndlessWalrusItem>(&arg0.items) > 0;
        if (!v8 && !v9) {
            abort 0
        };
        let v10 = if (v7 <= v3) {
            v7
        } else {
            v3
        };
        let v11 = 0x1::vector::empty<u8>();
        let v12 = 0x1::vector::empty<u8>();
        let v13 = 0;
        while (v13 < v7) {
            if (v13 < v10) {
                0x1::vector::push_back<u8>(&mut v11, *0x1::vector::borrow<u8>(&v0, v13));
            } else {
                0x1::vector::push_back<u8>(&mut v12, *0x1::vector::borrow<u8>(&v0, v13));
            };
            v13 = v13 + 1;
        };
        let v14 = 0x1::vector::length<u8>(&v12);
        if (v10 > v3) {
            if (v5 + v10 - v3 > 131072) {
                abort 94
            };
        };
        if (v8 && v14 > v4) {
            if (0x2::table::borrow<u64, EndlessWalrusHistory>(0x1::option::borrow<0x2::table::Table<u64, EndlessWalrusHistory>>(&arg0.history), arg1 + 1).storage_volume + v14 - v4 > 131072) {
                abort 94
            };
        };
        let v15 = 0x2::table::borrow_mut<u64, EndlessWalrusHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessWalrusHistory>>(&mut arg0.history), arg1);
        let v16 = &mut v15.items;
        if (v10 > v3) {
            v15.storage_volume = v15.storage_volume + v10 - v3;
        } else if (v10 < v3) {
            v15.storage_volume = v15.storage_volume - v3 - v10;
        };
        0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(swap_item_in_vec(v16, v2, 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::new_bytes_item(v11)));
        v15.followed_by_next_bytes = v14;
        if (v8) {
            let v17 = 0x2::table::borrow_mut<u64, EndlessWalrusHistory>(0x1::option::borrow_mut<0x2::table::Table<u64, EndlessWalrusHistory>>(&mut arg0.history), arg1 + 1);
            let v18 = &mut v17.items;
            if (v14 > v4) {
                v17.storage_volume = v17.storage_volume + v14 - v4;
            } else if (v14 < v4) {
                v17.storage_volume = v17.storage_volume - v4 - v14;
            };
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(swap_item_in_vec(v18, 0, 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::new_bytes_item(v12)));
        } else {
            if (v14 > v4) {
                let v19 = v14 - v4;
                if (arg0.this_object_storage_volume + v19 > 131072) {
                    abort 94
                };
                arg0.this_object_storage_volume = arg0.this_object_storage_volume + v19;
                arg0.this_object_items_binary_length = arg0.this_object_items_binary_length + v19;
            } else if (v14 < v4) {
                let v20 = v4 - v14;
                arg0.this_object_storage_volume = arg0.this_object_storage_volume - v20;
                arg0.this_object_items_binary_length = arg0.this_object_items_binary_length - v20;
            };
            let v21 = &mut arg0.items;
            0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::burn_item(swap_item_in_vec(v21, 0, 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item::new_bytes_item(v12)));
        };
    }

    // decompiled from Move bytecode v7
}

