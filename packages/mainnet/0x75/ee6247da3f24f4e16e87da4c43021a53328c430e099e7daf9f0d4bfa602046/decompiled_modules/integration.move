module 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::integration {
    struct SwaplockAttestor has key {
        id: 0x2::object::UID,
        verifier_cap: 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::VerifierCap,
        light_client_id: 0x2::object::ID,
    }

    public fun create_attestor(arg0: 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::VerifierCap, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SwaplockAttestor{
            id              : 0x2::object::new(arg2),
            verifier_cap    : arg0,
            light_client_id : arg1,
        };
        0x2::transfer::share_object<SwaplockAttestor>(v0);
    }

    public fun verify_and_submit_burn(arg0: &0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::SwaplockLightClient, arg1: &mut 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::BridgeCore, arg2: &0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::VerifierCap, arg3: u32, arg4: vector<u8>, arg5: vector<0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::merkle::MerkleStep>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: vector<u8>) {
        assert!(0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::is_final(arg0, arg3), 1);
        assert!(0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::merkle::verify_inclusion(arg4, arg5, 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::root_at(arg0, arg3)), 2);
        0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::submit_verified_deposit(arg1, arg2, arg6, arg7, arg8, arg9);
    }

    public fun verify_and_submit_burn_bound(arg0: &0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::SwaplockLightClient, arg1: &mut 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::BridgeCore, arg2: &0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::VerifierCap, arg3: u32, arg4: vector<u8>, arg5: vector<0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::merkle::MerkleStep>, arg6: vector<u8>) {
        assert!(0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::is_final(arg0, arg3), 1);
        let v0 = 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::swaplock_tx::leaf(arg4);
        assert!(0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::merkle::verify_inclusion(v0, arg5, 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::root_at(arg0, arg3)), 2);
        let (v1, v2, v3) = 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::swaplock_tx::parse_burn(arg4);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 8) {
            0x1::vector::push_back<u8>(&mut v4, ((v3 >> 8 * (v5 as u8) & 255) as u8));
            v5 = v5 + 1;
        };
        let v6 = 0;
        while (v6 < 8) {
            0x1::vector::push_back<u8>(&mut v4, ((v2 >> 8 * (v6 as u8) & 255) as u8));
            v6 = v6 + 1;
        };
        0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::submit_verified_deposit(arg1, arg2, v0, arg6, v1, v4);
    }

    public fun verify_and_submit_burn_bound_trapped(arg0: &0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::SwaplockLightClient, arg1: &SwaplockAttestor, arg2: &mut 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::BridgeCore, arg3: u32, arg4: vector<u8>, arg5: vector<0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::merkle::MerkleStep>, arg6: vector<u8>) {
        assert!(0x2::object::id<0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::SwaplockLightClient>(arg0) == arg1.light_client_id, 3);
        assert!(0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::is_final(arg0, arg3), 1);
        let v0 = 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::swaplock_tx::leaf(arg4);
        assert!(0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::merkle::verify_inclusion(v0, arg5, 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::root_at(arg0, arg3)), 2);
        let (v1, v2, v3) = 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::swaplock_tx::parse_burn(arg4);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 8) {
            0x1::vector::push_back<u8>(&mut v4, ((v3 >> 8 * (v5 as u8) & 255) as u8));
            v5 = v5 + 1;
        };
        let v6 = 0;
        while (v6 < 8) {
            0x1::vector::push_back<u8>(&mut v4, ((v2 >> 8 * (v6 as u8) & 255) as u8));
            v6 = v6 + 1;
        };
        0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::submit_verified_deposit(arg2, &arg1.verifier_cap, v0, arg6, v1, v4);
    }

    public fun verify_and_submit_burn_bound_trapped_v2(arg0: &0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::SwaplockLightClient, arg1: &SwaplockAttestor, arg2: &mut 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::BridgeCore, arg3: u32, arg4: vector<u8>, arg5: vector<0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::merkle::MerkleStep>, arg6: vector<u8>) {
        assert!(0x2::object::id<0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::SwaplockLightClient>(arg0) == arg1.light_client_id, 3);
        assert!(0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::is_final(arg0, arg3), 1);
        let v0 = 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::swaplock_tx::leaf(arg4);
        assert!(0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::merkle::verify_inclusion(v0, arg5, 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client::root_at(arg0, arg3)), 2);
        let (v1, v2, v3, v4) = 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::swaplock_tx::parse_burn_v2(arg4);
        let v5 = v4;
        let v6 = 0;
        while (v6 < 8) {
            0x1::vector::push_back<u8>(&mut v5, ((v2 >> 8 * (v6 as u8) & 255) as u8));
            v6 = v6 + 1;
        };
        let v7 = 0;
        while (v7 < 8) {
            0x1::vector::push_back<u8>(&mut v5, ((v3 >> 8 * (v7 as u8) & 255) as u8));
            v7 = v7 + 1;
        };
        0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::submit_verified_deposit(arg2, &arg1.verifier_cap, v0, arg6, v1, v5);
    }

    // decompiled from Move bytecode v7
}

