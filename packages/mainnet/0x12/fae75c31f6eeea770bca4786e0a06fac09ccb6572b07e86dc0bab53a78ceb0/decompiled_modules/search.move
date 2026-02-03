module 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::search {
    struct SearchIndex has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        embedding_hashes: vector<u256>,
        bucket_index: 0x2::table::Table<u64, vector<u256>>,
        total_entries: u64,
    }

    struct SearchIndexCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct SearchMatch has copy, drop, store {
        embedding_hash: u256,
        source_memory_key: vector<u8>,
        source_memory_type: u8,
        bucket_overlap: u64,
    }

    public fun create_index(arg0: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault, arg1: &0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVaultOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : (SearchIndex, SearchIndexCap) {
        assert!(0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::vault_owner_cap_for(arg1) == 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg0), 0);
        let v0 = SearchIndex{
            id               : 0x2::object::new(arg2),
            vault_id         : 0x2::object::id<0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_vault::MemoryVault>(arg0),
            embedding_hashes : 0x1::vector::empty<u256>(),
            bucket_index     : 0x2::table::new<u64, vector<u256>>(arg2),
            total_entries    : 0,
        };
        let v1 = SearchIndexCap{
            id  : 0x2::object::new(arg2),
            for : 0x2::object::id<SearchIndex>(&v0),
        };
        (v0, v1)
    }

    public fun get_bucket_entries(arg0: &SearchIndex, arg1: u64) : vector<u256> {
        if (0x2::table::contains<u64, vector<u256>>(&arg0.bucket_index, arg1)) {
            *0x2::table::borrow<u64, vector<u256>>(&arg0.bucket_index, arg1)
        } else {
            0x1::vector::empty<u256>()
        }
    }

    public fun get_embedding_hashes(arg0: &SearchIndex, arg1: u64, arg2: u64) : vector<u256> {
        let v0 = 0x1::vector::length<u256>(&arg0.embedding_hashes);
        assert!(arg1 <= v0, 2);
        let v1 = if (arg1 + arg2 > v0) {
            v0
        } else {
            arg1 + arg2
        };
        let v2 = 0x1::vector::empty<u256>();
        while (arg1 < v1) {
            0x1::vector::push_back<u256>(&mut v2, *0x1::vector::borrow<u256>(&arg0.embedding_hashes, arg1));
            arg1 = arg1 + 1;
        };
        v2
    }

    public fun has_bucket(arg0: &SearchIndex, arg1: u64) : bool {
        0x2::table::contains<u64, vector<u256>>(&arg0.bucket_index, arg1)
    }

    public fun index_entry(arg0: &mut SearchIndex, arg1: &SearchIndexCap, arg2: u256, arg3: vector<u8>, arg4: u8, arg5: vector<u64>) {
        assert!(0x2::object::id<SearchIndex>(arg0) == arg1.for, 0);
        0x1::vector::push_back<u256>(&mut arg0.embedding_hashes, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg5)) {
            let v1 = *0x1::vector::borrow<u64>(&arg5, v0);
            if (!0x2::table::contains<u64, vector<u256>>(&arg0.bucket_index, v1)) {
                0x2::table::add<u64, vector<u256>>(&mut arg0.bucket_index, v1, 0x1::vector::empty<u256>());
            };
            0x1::vector::push_back<u256>(0x2::table::borrow_mut<u64, vector<u256>>(&mut arg0.bucket_index, v1), arg2);
            v0 = v0 + 1;
        };
        arg0.total_entries = arg0.total_entries + 1;
    }

    public fun search_by_buckets(arg0: &SearchIndex, arg1: vector<u64>, arg2: u64, arg3: u64) : vector<SearchMatch> {
        let v0 = 0x1::vector::empty<SearchMatch>();
        let v1 = 0x2::vec_map::empty<u256, u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v2);
            if (0x2::table::contains<u64, vector<u256>>(&arg0.bucket_index, v3)) {
                let v4 = 0x2::table::borrow<u64, vector<u256>>(&arg0.bucket_index, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<u256>(v4)) {
                    let v6 = *0x1::vector::borrow<u256>(v4, v5);
                    if (0x2::vec_map::contains<u256, u64>(&v1, &v6)) {
                        let v7 = 0x2::vec_map::get_mut<u256, u64>(&mut v1, &v6);
                        *v7 = *v7 + 1;
                    } else {
                        0x2::vec_map::insert<u256, u64>(&mut v1, v6, 1);
                    };
                    v5 = v5 + 1;
                };
            };
            v2 = v2 + 1;
        };
        let v8 = 0x2::vec_map::keys<u256, u64>(&v1);
        let v9 = 0;
        let v10 = 0;
        while (v9 < 0x1::vector::length<u256>(&v8) && v10 < arg3) {
            let v11 = *0x1::vector::borrow<u256>(&v8, v9);
            let v12 = *0x2::vec_map::get<u256, u64>(&v1, &v11);
            if (v12 >= arg2) {
                let v13 = SearchMatch{
                    embedding_hash     : v11,
                    source_memory_key  : 0x1::vector::empty<u8>(),
                    source_memory_type : 0,
                    bucket_overlap     : v12,
                };
                0x1::vector::push_back<SearchMatch>(&mut v0, v13);
                v10 = v10 + 1;
            };
            v9 = v9 + 1;
        };
        v0
    }

    public fun total_entries(arg0: &SearchIndex) : u64 {
        arg0.total_entries
    }

    public fun vault_id(arg0: &SearchIndex) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

