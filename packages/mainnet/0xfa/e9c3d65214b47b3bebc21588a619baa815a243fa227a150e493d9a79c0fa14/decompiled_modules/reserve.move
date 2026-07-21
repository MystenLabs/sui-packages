module 0xfae9c3d65214b47b3bebc21588a619baa815a243fa227a150e493d9a79c0fa14::reserve {
    struct Reserve has key {
        id: 0x2::object::UID,
        dwallet_cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap,
        reserve_cap: 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::ReserveCap,
        issuer_account: u64,
        source_chain: vector<u8>,
    }

    struct EthAddressRegistry has key {
        id: 0x2::object::UID,
        addrs: 0x2::table::Table<u64, vector<u8>>,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun approve(arg0: &Reserve, arg1: &mut 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::BridgeCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: vector<u8>, arg4: u32, arg5: u32) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval {
        let (_, v1) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::consume_withdrawal(arg1, &arg0.reserve_cap, arg3);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg2, &arg0.dwallet_cap, arg4, arg5, v1)
    }

    public fun approve_asset_create(arg0: &Reserve, arg1: &0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::BridgeCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: &0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::AdminCap, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u32, arg8: u32) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval {
        let (v0, _, v2, _, _, _, v6) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::asset_info(arg1, arg4, arg5);
        assert!(v6 == 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::asset_status_pending(), 14);
        let (v7, v8, v9) = parse_asset_create(&arg6);
        assert!(v7 == arg0.issuer_account, 15);
        assert!(v8 == v0, 16);
        assert!(v9 == v2, 17);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg2, &arg0.dwallet_cap, arg7, arg8, arg6)
    }

    public fun approve_mint(arg0: &Reserve, arg1: &mut 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::BridgeCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: vector<u8>, arg4: vector<u8>, arg5: u32, arg6: u32) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval {
        let (v0, v1) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::consume_withdrawal(arg1, &arg0.reserve_cap, arg3);
        let v2 = v1;
        let v3 = slice(&v2, 8, 28);
        assert!(0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::has_asset(arg1, arg0.source_chain, v3), 18);
        let (_, v5, _, _, _, v9, v10) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::asset_info(arg1, arg0.source_chain, v3);
        assert!(v10 == 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::asset_status_active(), 19);
        assert!(v0 <= v9, 21);
        let (v11, v12, v13) = parse_asset_issue(&arg4);
        assert!(v12 == le_u64_at(&v2, 0), 10);
        assert!(v11 == v0, 11);
        assert!(v13 == v5, 20);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg2, &arg0.dwallet_cap, arg5, arg6, arg4)
    }

    public fun approve_redemption(arg0: &Reserve, arg1: &mut 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::BridgeCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: &EthAddressRegistry, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: u32) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval {
        let (v0, v1) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::consume_withdrawal(arg1, &arg0.reserve_cap, arg4);
        let v2 = v1;
        let v3 = le_u64_at(&v2, 0);
        let v4 = le_u64_at(&v2, 8);
        assert!(0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::has_asset_by_id(arg1, v4), 18);
        let (v5, v6) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::route_by_asset_id(arg1, v4);
        let (_, v8, _, _, v11, _, v13) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::asset_info(arg1, v5, v6);
        assert!(v13 == 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::asset_status_active(), 19);
        assert!(v8 == v4, 20);
        assert!(0x2::table::contains<u64, vector<u8>>(&arg3.addrs, v3), 13);
        let (v14, v15, _) = parse_eip1559(&arg5);
        assert!(v14 == *0x2::table::borrow<u64, vector<u8>>(&arg3.addrs, v3), 10);
        assert!(v15 == (v0 as u256) * v11, 11);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg2, &arg0.dwallet_cap, arg6, arg7, arg5)
    }

    public fun approve_redemption_v2(arg0: &Reserve, arg1: &mut 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::BridgeCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: vector<u8>, arg4: vector<u8>, arg5: u32, arg6: u32) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval {
        let (v0, v1) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::consume_withdrawal(arg1, &arg0.reserve_cap, arg3);
        let v2 = v1;
        let v3 = slice(&v2, 0, 20);
        let v4 = le_u64_at(&v2, 20);
        assert!(le_u64_at(&v2, 28) == arg0.issuer_account, 22);
        assert!(0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::has_asset_by_id(arg1, v4), 18);
        let (v5, v6) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::route_by_asset_id(arg1, v4);
        let v7 = v6;
        let (_, v9, _, _, v12, _, v14) = 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::asset_info(arg1, v5, v7);
        assert!(v14 == 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::asset_status_active(), 19);
        assert!(v9 == v4, 20);
        let (v15, v16, v17) = parse_eip1559(&arg4);
        let v18 = v17;
        if (is_native_sentinel(&v7)) {
            assert!(v15 == v3, 10);
            assert!(v16 == (v0 as u256) * v12, 11);
            assert!(0x1::vector::length<u8>(&v18) == 0, 12);
        } else {
            assert!(v15 == v7, 10);
            assert!(v16 == 0, 11);
            assert_erc20_transfer(&v18, &v3, (v0 as u256) * v12);
        };
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg2, &arg0.dwallet_cap, arg5, arg6, arg4)
    }

    fun assert_erc20_transfer(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u256) {
        assert!(0x1::vector::length<u8>(arg0) == 68, 12);
        assert!(slice(arg0, 0, 4) == x"a9059cbb", 12);
        let v0 = 4;
        while (v0 < 16) {
            assert!(*0x1::vector::borrow<u8>(arg0, v0) == 0, 10);
            v0 = v0 + 1;
        };
        assert!(slice(arg0, 16, 36) == *arg1, 10);
        let v1 = slice(arg0, 36, 68);
        assert!(be_to_u256(&v1) == arg2, 11);
    }

    fun be_to_u256(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    fun be_to_u64(arg0: &vector<u8>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun create(arg0: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg1: 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::ReserveCap, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserve{
            id             : 0x2::object::new(arg4),
            dwallet_cap    : arg0,
            reserve_cap    : arg1,
            issuer_account : arg2,
            source_chain   : arg3,
        };
        0x2::transfer::share_object<Reserve>(v0);
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EthAddressRegistry{
            id    : 0x2::object::new(arg0),
            addrs : 0x2::table::new<u64, vector<u8>>(arg0),
        };
        0x2::transfer::share_object<EthAddressRegistry>(v0);
        let v1 = RegistryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RegistryAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun fc_varint(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = arg1;
        loop {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            v2 = v2 + 1;
            v0 = v0 | ((v3 & 127) as u64) << v1;
            if (v3 < 128) {
                break
            };
            v1 = v1 + 7;
        };
        (v0, v2)
    }

    fun is_native_sentinel(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun le_u64_at(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << ((8 * v1) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    fun parse_asset_create(arg0: &vector<u8>) : (u64, vector<u8>, u8) {
        let (v0, v1) = fc_varint(arg0, 42);
        assert!(v0 == 1, 12);
        let (v2, v3) = fc_varint(arg0, v1);
        assert!(v2 == 10, 12);
        let (_, v5) = fc_varint(arg0, v3 + 8);
        let (v6, v7) = fc_varint(arg0, v5);
        let (v8, v9) = fc_varint(arg0, v7);
        let v10 = v9 + v8;
        assert!(v10 < 0x1::vector::length<u8>(arg0), 12);
        (v6, slice(arg0, v9, v9 + v8), *0x1::vector::borrow<u8>(arg0, v10))
    }

    fun parse_asset_issue(arg0: &vector<u8>) : (u64, u64, u64) {
        let (_, v1) = fc_varint(arg0, 42);
        let (v2, v3) = fc_varint(arg0, v1);
        assert!(v2 == 14, 12);
        let (_, v5) = fc_varint(arg0, v3 + 8);
        let (_, v7) = fc_varint(arg0, v5);
        let (v8, v9) = fc_varint(arg0, v7 + 8);
        let (v10, _) = fc_varint(arg0, v9);
        (read_i64_le_as_u64(arg0, v7), v10, v8)
    }

    fun parse_eip1559(arg0: &vector<u8>) : (vector<u8>, u256, vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 2, 12);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 2, 12);
        let v0 = *0x1::vector::borrow<u8>(arg0, 1);
        let v1 = if (v0 <= 247) {
            2
        } else {
            2 + ((v0 - 247) as u64)
        };
        let v2 = v1;
        let v3 = 0;
        while (v3 < 5) {
            v2 = skip_rlp_item(arg0, v2);
            v3 = v3 + 1;
        };
        let (v4, v5) = read_rlp_item(arg0, v2);
        let (v6, v7) = read_rlp_item(arg0, v5);
        let v8 = v6;
        let (v9, _) = read_rlp_item(arg0, v7);
        (v4, be_to_u256(&v8), v9)
    }

    fun read_i64_le_as_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << ((8 * v1) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    fun read_rlp_item(arg0: &vector<u8>, arg1: u64) : (vector<u8>, u64) {
        let v0 = *0x1::vector::borrow<u8>(arg0, arg1);
        if (v0 < 128) {
            let v3 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v3, v0);
            (v3, arg1 + 1)
        } else if (v0 <= 183) {
            let v4 = ((v0 - 128) as u64);
            (slice(arg0, arg1 + 1, arg1 + 1 + v4), arg1 + 1 + v4)
        } else {
            let v5 = ((v0 - 183) as u64);
            let v6 = be_to_u64(arg0, arg1 + 1, v5);
            (slice(arg0, arg1 + 1 + v5, arg1 + 1 + v5 + v6), arg1 + 1 + v5 + v6)
        }
    }

    public fun register_eth_address(arg0: &mut EthAddressRegistry, arg1: &RegistryAdminCap, arg2: u64, arg3: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg3) == 20, 12);
        if (0x2::table::contains<u64, vector<u8>>(&arg0.addrs, arg2)) {
            *0x2::table::borrow_mut<u64, vector<u8>>(&mut arg0.addrs, arg2) = arg3;
        } else {
            0x2::table::add<u64, vector<u8>>(&mut arg0.addrs, arg2, arg3);
        };
    }

    fun skip_rlp_item(arg0: &vector<u8>, arg1: u64) : u64 {
        let (_, v1) = read_rlp_item(arg0, arg1);
        v1
    }

    fun slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        assert!(arg2 <= 0x1::vector::length<u8>(arg0), 12);
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

