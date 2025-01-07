module 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions {
    struct PermissionsStorage has store, key {
        id: 0x2::object::UID,
        _admin: address,
        _proposerIndex: 0x2::table::Table<address, u64>,
        _proposerList: vector<address>,
        _executorsForIndex: vector<vector<vector<u8>>>,
        _exeThresholdForIndex: vector<u64>,
        _exeActiveSinceForIndex: vector<u64>,
    }

    struct AdminTransferred has copy, drop {
        prevAdmin: address,
        newAdmin: address,
    }

    struct ProposerAdded has copy, drop {
        proposer: address,
    }

    struct ProposerRemoved has copy, drop {
        proposer: address,
    }

    public entry fun addProposer(arg0: address, arg1: &mut PermissionsStorage, arg2: &mut 0x2::tx_context::TxContext) {
        assertOnlyAdmin(arg1, arg2);
        addProposerInternal(arg0, arg1);
    }

    public(friend) fun addProposerInternal(arg0: address, arg1: &mut PermissionsStorage) {
        assert!(!0x2::table::contains<address, u64>(&arg1._proposerIndex, arg0), 22);
        0x1::vector::push_back<address>(&mut arg1._proposerList, arg0);
        0x2::table::add<address, u64>(&mut arg1._proposerIndex, arg0, 0x1::vector::length<address>(&arg1._proposerList));
        let v0 = ProposerAdded{proposer: arg0};
        0x2::event::emit<ProposerAdded>(v0);
    }

    public(friend) fun assertOnlyAdmin(arg0: &PermissionsStorage, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0._admin, 20);
    }

    public(friend) fun assertOnlyProposer(arg0: &PermissionsStorage, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u64>(&arg0._proposerIndex, 0x2::tx_context::sender(arg1)), 21);
    }

    fun checkExecutorsForIndex(arg0: vector<vector<u8>>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &PermissionsStorage) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::assertEthAddressList(arg0);
        assert!(0x1::vector::length<vector<u8>>(&arg0) >= *0x1::vector::borrow<u64>(&arg3._exeThresholdForIndex, arg1), 27);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(*0x1::vector::borrow<u64>(&arg3._exeActiveSinceForIndex, arg1) < v0, 28);
        if (0x1::vector::length<u64>(&arg3._exeActiveSinceForIndex) > arg1 + 1) {
            assert!(*0x1::vector::borrow<u64>(&arg3._exeActiveSinceForIndex, arg1 + 1) > v0, 29);
        };
        let v1 = *0x1::vector::borrow<vector<vector<u8>>>(&arg3._executorsForIndex, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg0, v2);
            let v4 = 0;
            while (v4 < v2) {
                assert!(*0x1::vector::borrow<vector<u8>>(&arg0, v4) != v3, 30);
                v4 = v4 + 1;
            };
            let v5 = false;
            let v6 = 0;
            while (v6 < 0x1::vector::length<vector<u8>>(&v1)) {
                if (v3 == *0x1::vector::borrow<vector<u8>>(&v1, v6)) {
                    v5 = true;
                    break
                };
                v6 = v6 + 1;
            };
            assert!(v5, 31);
            v2 = v2 + 1;
        };
    }

    public(friend) fun checkMultiSignatures(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &PermissionsStorage) {
        assert!(0x1::vector::length<vector<u8>>(&arg1) == 0x1::vector::length<vector<u8>>(&arg2), 26);
        assert!(0x1::vector::length<vector<u8>>(&arg1) == 0x1::vector::length<vector<u8>>(&arg3), 26);
        checkExecutorsForIndex(arg3, arg4, arg5, arg6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg3)) {
            checkSignature(arg0, *0x1::vector::borrow<vector<u8>>(&arg1, v0), *0x1::vector::borrow<vector<u8>>(&arg2, v0), *0x1::vector::borrow<vector<u8>>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    fun checkSignature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(arg3 != x"0000000000000000000000000000000000000000", 32);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 33);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 33);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 33);
        assert!(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::recoverEthAddress(arg0, arg1, arg2) == arg3, 34);
    }

    fun cmpAddrList(arg0: vector<vector<u8>>, arg1: vector<vector<u8>>) : bool {
        if (0x1::vector::length<vector<u8>>(&arg0) > 0x1::vector::length<vector<u8>>(&arg1)) {
            true
        } else if (0x1::vector::length<vector<u8>>(&arg0) < 0x1::vector::length<vector<u8>>(&arg1)) {
            false
        } else {
            let v1 = 0;
            while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
                let v2 = 0x1::vector::empty<vector<u8>>();
                let v3 = &mut v2;
                0x1::vector::push_back<vector<u8>>(v3, x"000000000000000000000000");
                0x1::vector::push_back<vector<u8>>(v3, *0x1::vector::borrow<vector<u8>>(&arg0, v1));
                let v4 = 0x1::vector::empty<vector<u8>>();
                let v5 = &mut v4;
                0x1::vector::push_back<vector<u8>>(v5, x"000000000000000000000000");
                0x1::vector::push_back<vector<u8>>(v5, *0x1::vector::borrow<vector<u8>>(&arg1, v1));
                let v6 = 0x2::address::to_u256(0x2::address::from_bytes(0x1::vector::flatten<u8>(v2)));
                let v7 = 0x2::address::to_u256(0x2::address::from_bytes(0x1::vector::flatten<u8>(v4)));
                if (v6 > v7) {
                    return true
                };
                if (v6 < v7) {
                    return false
                };
                v1 = v1 + 1;
            };
            false
        }
    }

    public(friend) fun initAdminInternal(arg0: address, arg1: &mut PermissionsStorage) {
        arg1._admin = arg0;
        let v0 = AdminTransferred{
            prevAdmin : @0x0,
            newAdmin  : arg0,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public entry fun initExecutors(arg0: vector<vector<u8>>, arg1: u64, arg2: &mut PermissionsStorage, arg3: &mut 0x2::tx_context::TxContext) {
        assertOnlyAdmin(arg2, arg3);
        initExecutorsInternal(arg0, arg1, arg2);
    }

    public(friend) fun initExecutorsInternal(arg0: vector<vector<u8>>, arg1: u64, arg2: &mut PermissionsStorage) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::assertEthAddressList(arg0);
        assert!(0x1::vector::length<u64>(&arg2._exeThresholdForIndex) == 0, 24);
        assert!(arg1 > 0, 25);
        0x1::vector::push_back<vector<vector<u8>>>(&mut arg2._executorsForIndex, arg0);
        0x1::vector::push_back<u64>(&mut arg2._exeThresholdForIndex, arg1);
        0x1::vector::push_back<u64>(&mut arg2._exeActiveSinceForIndex, 1);
    }

    public(friend) fun initPermissionsStorage(arg0: &mut 0x2::tx_context::TxContext) : PermissionsStorage {
        PermissionsStorage{
            id                      : 0x2::object::new(arg0),
            _admin                  : 0x2::tx_context::sender(arg0),
            _proposerIndex          : 0x2::table::new<address, u64>(arg0),
            _proposerList           : 0x1::vector::empty<address>(),
            _executorsForIndex      : 0x1::vector::empty<vector<vector<u8>>>(),
            _exeThresholdForIndex   : 0x1::vector::empty<u64>(),
            _exeActiveSinceForIndex : 0x1::vector::empty<u64>(),
        }
    }

    fun joinAddressList(arg0: vector<vector<u8>>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v2 = 0x1::vector::empty<vector<u8>>();
            let v3 = &mut v2;
            0x1::vector::push_back<vector<u8>>(v3, *0x1::vector::borrow<vector<u8>>(&arg0, v1));
            0x1::vector::push_back<vector<u8>>(v3, x"000000000000000000000000");
            let v4 = 0x2::address::to_string(0x2::address::from_bytes(0x1::vector::flatten<u8>(v2)));
            let v5 = 0x1::string::as_bytes(&v4);
            let v6 = 0x1::vector::empty<u8>();
            let v7 = 0;
            while (v7 < 40) {
                0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(v5, v7));
                v7 = v7 + 1;
            };
            let v8 = 0x1::vector::empty<vector<u8>>();
            let v9 = &mut v8;
            0x1::vector::push_back<vector<u8>>(v9, b"0x");
            0x1::vector::push_back<vector<u8>>(v9, v6);
            0x1::vector::push_back<vector<u8>>(v9, x"0a");
            0x1::vector::append<u8>(&mut v0, 0x1::vector::flatten<u8>(v8));
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun removeProposer(arg0: address, arg1: &mut PermissionsStorage, arg2: &mut 0x2::tx_context::TxContext) {
        assertOnlyAdmin(arg1, arg2);
        assert!(0x2::table::contains<address, u64>(&arg1._proposerIndex, arg0), 23);
        let v0 = 0x2::table::remove<address, u64>(&mut arg1._proposerIndex, arg0);
        let v1 = 0x1::vector::length<address>(&arg1._proposerList);
        if (v0 < v1) {
            let v2 = *0x1::vector::borrow<address>(&arg1._proposerList, v1 - 1);
            *0x1::vector::borrow_mut<address>(&mut arg1._proposerList, v0) = v2;
            *0x2::table::borrow_mut<address, u64>(&mut arg1._proposerIndex, v2) = v0;
        };
        0x1::vector::pop_back<address>(&mut arg1._proposerList);
        let v3 = ProposerRemoved{proposer: arg0};
        0x2::event::emit<ProposerRemoved>(v3);
    }

    public entry fun transferAdmin(arg0: address, arg1: &mut PermissionsStorage, arg2: &mut 0x2::tx_context::TxContext) {
        assertOnlyAdmin(arg1, arg2);
        arg1._admin = arg0;
        let v0 = AdminTransferred{
            prevAdmin : arg1._admin,
            newAdmin  : arg0,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public entry fun updateExecutors(arg0: vector<vector<u8>>, arg1: u64, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut PermissionsStorage) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::assertEthAddressList(arg0);
        assert!(arg1 > 0, 25);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg7) / 1000 + 129600, 35);
        assert!(arg2 < 0x2::clock::timestamp_ms(arg7) / 1000 + 432000, 36);
        let v0 = 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::BRIDGE_CHANNEL();
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = &mut v1;
        0x1::vector::push_back<vector<u8>>(v2, x"19457468657265756d205369676e6564204d6573736167653a0a");
        0x1::vector::push_back<vector<u8>>(v2, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::smallU64ToString(3 + 0x1::vector::length<u8>(&v0) + 29 + 43 * 0x1::vector::length<vector<u8>>(&arg0) + 12 + 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::smallU64Log10(arg1) + 1 + 25 + 25 + 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::smallU64Log10(arg6) + 1));
        0x1::vector::push_back<vector<u8>>(v2, b"[");
        0x1::vector::push_back<vector<u8>>(v2, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::BRIDGE_CHANNEL());
        0x1::vector::push_back<vector<u8>>(v2, x"5d0a");
        0x1::vector::push_back<vector<u8>>(v2, x"5369676e20746f20757064617465206578656375746f727320746f3a0a");
        0x1::vector::push_back<vector<u8>>(v2, joinAddressList(arg0));
        0x1::vector::push_back<vector<u8>>(v2, b"Threshold: ");
        0x1::vector::push_back<vector<u8>>(v2, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::smallU64ToString(arg1));
        0x1::vector::push_back<vector<u8>>(v2, x"0a");
        0x1::vector::push_back<vector<u8>>(v2, b"Active since: ");
        0x1::vector::push_back<vector<u8>>(v2, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::smallU64ToString(arg2));
        0x1::vector::push_back<vector<u8>>(v2, x"0a");
        0x1::vector::push_back<vector<u8>>(v2, b"Current executors index: ");
        0x1::vector::push_back<vector<u8>>(v2, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::smallU64ToString(arg6));
        checkMultiSignatures(0x1::vector::flatten<u8>(v1), arg3, arg4, arg5, arg6, arg7, arg8);
        let v3 = arg6 + 1;
        if (v3 == 0x1::vector::length<u64>(&arg8._exeActiveSinceForIndex)) {
            0x1::vector::push_back<vector<vector<u8>>>(&mut arg8._executorsForIndex, arg0);
            0x1::vector::push_back<u64>(&mut arg8._exeThresholdForIndex, arg1);
            0x1::vector::push_back<u64>(&mut arg8._exeActiveSinceForIndex, arg2);
        } else {
            assert!(arg2 >= *0x1::vector::borrow<u64>(&arg8._exeActiveSinceForIndex, v3), 37);
            assert!(arg1 >= *0x1::vector::borrow<u64>(&arg8._exeThresholdForIndex, v3), 37);
            assert!(cmpAddrList(arg0, *0x1::vector::borrow<vector<vector<u8>>>(&arg8._executorsForIndex, v3)), 37);
            *0x1::vector::borrow_mut<vector<vector<u8>>>(&mut arg8._executorsForIndex, v3) = arg0;
            *0x1::vector::borrow_mut<u64>(&mut arg8._exeThresholdForIndex, v3) = arg1;
            *0x1::vector::borrow_mut<u64>(&mut arg8._exeActiveSinceForIndex, v3) = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

