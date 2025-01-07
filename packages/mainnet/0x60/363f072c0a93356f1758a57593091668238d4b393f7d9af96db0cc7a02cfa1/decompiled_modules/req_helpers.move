module 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers {
    struct ReqHelpersStorage has store, key {
        id: 0x2::object::UID,
        tokens: 0x2::table::Table<u8, 0x1::type_name::TypeName>,
        tokenDecimals: 0x2::table::Table<u8, u8>,
    }

    struct TokenAdded has copy, drop {
        tokenIndex: u8,
        tokenType: 0x1::type_name::TypeName,
    }

    struct TokenRemoved has copy, drop {
        tokenIndex: u8,
        tokenType: 0x1::type_name::TypeName,
    }

    public(friend) fun actionFrom(arg0: vector<u8>) : u8 {
        *0x1::vector::borrow<u8>(&arg0, 6)
    }

    public(friend) fun addTokenInternal<T0>(arg0: u8, arg1: u8, arg2: &mut ReqHelpersStorage) {
        assert!(!0x2::table::contains<u8, 0x1::type_name::TypeName>(&arg2.tokens, arg0), 0);
        assert!(arg0 > 0, 1);
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::add<u8, 0x1::type_name::TypeName>(&mut arg2.tokens, arg0, v0);
        0x2::table::add<u8, u8>(&mut arg2.tokenDecimals, arg0, arg1);
        let v1 = TokenAdded{
            tokenIndex : arg0,
            tokenType  : v0,
        };
        0x2::event::emit<TokenAdded>(v1);
    }

    public(friend) fun amountFrom(arg0: vector<u8>, arg1: &ReqHelpersStorage) : u64 {
        let v0 = decodeAmount(arg0);
        let v1 = v0;
        let v2 = decodeTokenIndex(arg0);
        if (v2 >= 192) {
            let v3 = *0x2::table::borrow<u8, u8>(&arg1.tokenDecimals, v2);
            if (v3 > 6) {
                v1 = v0 * 0x1::u64::pow(10, v3 - 6);
            } else {
                v1 = v0 / 0x1::u64::pow(10, 6 - v3);
            };
        } else if (v2 >= 64) {
            v1 = v0 * 0x1::u64::pow(10, 12);
        };
        v1
    }

    public(friend) fun assertFromChainOnly(arg0: vector<u8>) {
        assert!(160 == *0x1::vector::borrow<u8>(&arg0, 16), 4);
    }

    public(friend) fun assertToChainOnly(arg0: vector<u8>) {
        assert!(160 == *0x1::vector::borrow<u8>(&arg0, 17), 5);
    }

    public(friend) fun checkCreatedTimeFrom(arg0: vector<u8>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = createdTimeFrom(arg0);
        assert!(v0 > 0x2::clock::timestamp_ms(arg1) / 1000 - 172800, 6);
        assert!(v0 < 0x2::clock::timestamp_ms(arg1) / 1000 + 60, 7);
        v0
    }

    fun checkTokenType<T0>(arg0: u8, arg1: &ReqHelpersStorage) {
        assert!(*0x2::table::borrow<u8, 0x1::type_name::TypeName>(&arg1.tokens, arg0) == 0x1::type_name::get<T0>(), 10);
    }

    public(friend) fun createdTimeFrom(arg0: vector<u8>) : u64 {
        let v0 = (*0x1::vector::borrow<u8>(&arg0, 1) as u64);
        let v1 = 2;
        while (v1 < 6) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(&arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    fun decodeAmount(arg0: vector<u8>) : u64 {
        let v0 = (*0x1::vector::borrow<u8>(&arg0, 8) as u64);
        let v1 = 9;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(&arg0, v1) as u64);
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 8);
        v0
    }

    fun decodeTokenIndex(arg0: vector<u8>) : u8 {
        *0x1::vector::borrow<u8>(&arg0, 7)
    }

    public(friend) fun initReqHelpersStorage(arg0: &mut 0x2::tx_context::TxContext) : ReqHelpersStorage {
        ReqHelpersStorage{
            id            : 0x2::object::new(arg0),
            tokens        : 0x2::table::new<u8, 0x1::type_name::TypeName>(arg0),
            tokenDecimals : 0x2::table::new<u8, u8>(arg0),
        }
    }

    public(friend) fun msgFromReqSigningMessage(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 3);
        let v0 = actionFrom(arg0) & 15;
        let v1 = &v0;
        if (*v1 == 1) {
            let v3 = 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::BRIDGE_CHANNEL();
            let v4 = 0x1::vector::empty<vector<u8>>();
            let v5 = &mut v4;
            0x1::vector::push_back<vector<u8>>(v5, x"19457468657265756d205369676e6564204d6573736167653a0a");
            0x1::vector::push_back<vector<u8>>(v5, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::smallU64ToString(3 + 0x1::vector::length<u8>(&v3) + 29 + 66));
            0x1::vector::push_back<vector<u8>>(v5, b"[");
            0x1::vector::push_back<vector<u8>>(v5, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::BRIDGE_CHANNEL());
            0x1::vector::push_back<vector<u8>>(v5, x"5d0a");
            0x1::vector::push_back<vector<u8>>(v5, x"5369676e20746f20657865637574652061206c6f636b2d6d696e743a0a");
            0x1::vector::push_back<vector<u8>>(v5, b"0x");
            0x1::vector::push_back<vector<u8>>(v5, 0x2::hex::encode(arg0));
            0x1::vector::flatten<u8>(v4)
        } else if (*v1 == 2) {
            let v6 = 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::BRIDGE_CHANNEL();
            let v7 = 0x1::vector::empty<vector<u8>>();
            let v8 = &mut v7;
            0x1::vector::push_back<vector<u8>>(v8, x"19457468657265756d205369676e6564204d6573736167653a0a");
            0x1::vector::push_back<vector<u8>>(v8, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::smallU64ToString(3 + 0x1::vector::length<u8>(&v6) + 31 + 66));
            0x1::vector::push_back<vector<u8>>(v8, b"[");
            0x1::vector::push_back<vector<u8>>(v8, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::BRIDGE_CHANNEL());
            0x1::vector::push_back<vector<u8>>(v8, x"5d0a");
            0x1::vector::push_back<vector<u8>>(v8, x"5369676e20746f20657865637574652061206275726e2d756e6c6f636b3a0a");
            0x1::vector::push_back<vector<u8>>(v8, b"0x");
            0x1::vector::push_back<vector<u8>>(v8, 0x2::hex::encode(arg0));
            0x1::vector::flatten<u8>(v7)
        } else if (*v1 == 3) {
            let v9 = 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::BRIDGE_CHANNEL();
            let v10 = 0x1::vector::empty<vector<u8>>();
            let v11 = &mut v10;
            0x1::vector::push_back<vector<u8>>(v11, x"19457468657265756d205369676e6564204d6573736167653a0a");
            0x1::vector::push_back<vector<u8>>(v11, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::smallU64ToString(3 + 0x1::vector::length<u8>(&v9) + 29 + 66));
            0x1::vector::push_back<vector<u8>>(v11, b"[");
            0x1::vector::push_back<vector<u8>>(v11, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::BRIDGE_CHANNEL());
            0x1::vector::push_back<vector<u8>>(v11, x"5d0a");
            0x1::vector::push_back<vector<u8>>(v11, x"5369676e20746f20657865637574652061206275726e2d6d696e743a0a");
            0x1::vector::push_back<vector<u8>>(v11, b"0x");
            0x1::vector::push_back<vector<u8>>(v11, 0x2::hex::encode(arg0));
            0x1::vector::flatten<u8>(v10)
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public(friend) fun removeTokenInternal(arg0: u8, arg1: &mut ReqHelpersStorage) {
        assert!(0x2::table::contains<u8, 0x1::type_name::TypeName>(&arg1.tokens, arg0), 2);
        assert!(arg0 > 0, 1);
        if (arg0 >= 192) {
            0x2::table::remove<u8, u8>(&mut arg1.tokenDecimals, arg0);
        };
        let v0 = TokenRemoved{
            tokenIndex : arg0,
            tokenType  : 0x2::table::remove<u8, 0x1::type_name::TypeName>(&mut arg1.tokens, arg0),
        };
        0x2::event::emit<TokenRemoved>(v0);
    }

    public(friend) fun tokenIndexFrom<T0>(arg0: vector<u8>, arg1: &ReqHelpersStorage) : u8 {
        let v0 = decodeTokenIndex(arg0);
        assert!(0x2::table::contains<u8, 0x1::type_name::TypeName>(&arg1.tokens, v0), 2);
        checkTokenType<T0>(v0, arg1);
        v0
    }

    public(friend) fun versionFrom(arg0: vector<u8>) : u8 {
        *0x1::vector::borrow<u8>(&arg0, 0)
    }

    // decompiled from Move bytecode v6
}

