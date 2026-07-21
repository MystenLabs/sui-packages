module 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::guardian_set {
    struct GuardianSet has key {
        id: 0x2::object::UID,
        set_index: u32,
        guardians: 0x2::vec_map::VecMap<u8, vector<u8>>,
        quorum: u64,
        emitter_chain: u16,
        emitter_address: vector<u8>,
        processed: 0x2::table::Table<vector<u8>, bool>,
    }

    struct GuardianAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GuardianSetV2 has key {
        id: 0x2::object::UID,
        set_index: u32,
        guardians: 0x2::vec_map::VecMap<u8, vector<u8>>,
        quorum: u64,
        emitter_chain: u16,
        emitter_address: vector<u8>,
        processed: 0x2::table::Table<vector<u8>, bool>,
        verifier_cap: 0x3c549f2ed5cd05b87faafff02e6f7769dd51cc703090df0e962c5a8e1bbc937b::core::VerifierCap,
    }

    public fun create(arg0: u32, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: u64, arg4: u16, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 0x1::vector::length<vector<u8>>(&arg2), 2);
        let v0 = 0x2::vec_map::empty<u8, vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg1)) {
            0x2::vec_map::insert<u8, vector<u8>>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v1), *0x1::vector::borrow<vector<u8>>(&arg2, v1));
            v1 = v1 + 1;
        };
        let v2 = GuardianSet{
            id              : 0x2::object::new(arg6),
            set_index       : arg0,
            guardians       : v0,
            quorum          : arg3,
            emitter_chain   : arg4,
            emitter_address : arg5,
            processed       : 0x2::table::new<vector<u8>, bool>(arg6),
        };
        0x2::transfer::share_object<GuardianSet>(v2);
        let v3 = GuardianAdminCap{id: 0x2::object::new(arg6)};
        0x2::transfer::public_transfer<GuardianAdminCap>(v3, 0x2::tx_context::sender(arg6));
    }

    public fun create_v2(arg0: u32, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: u64, arg4: u16, arg5: vector<u8>, arg6: 0x3c549f2ed5cd05b87faafff02e6f7769dd51cc703090df0e962c5a8e1bbc937b::core::VerifierCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 0x1::vector::length<vector<u8>>(&arg2), 2);
        let v0 = 0x2::vec_map::empty<u8, vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg1)) {
            0x2::vec_map::insert<u8, vector<u8>>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v1), *0x1::vector::borrow<vector<u8>>(&arg2, v1));
            v1 = v1 + 1;
        };
        let v2 = GuardianSetV2{
            id              : 0x2::object::new(arg7),
            set_index       : arg0,
            guardians       : v0,
            quorum          : arg3,
            emitter_chain   : arg4,
            emitter_address : arg5,
            processed       : 0x2::table::new<vector<u8>, bool>(arg7),
            verifier_cap    : arg6,
        };
        0x2::transfer::share_object<GuardianSetV2>(v2);
    }

    public fun verify_and_submit(arg0: &mut GuardianSet, arg1: &mut 0x3c549f2ed5cd05b87faafff02e6f7769dd51cc703090df0e962c5a8e1bbc937b::core::BridgeCore, arg2: &0x3c549f2ed5cd05b87faafff02e6f7769dd51cc703090df0e962c5a8e1bbc937b::core::VerifierCap, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::parse(arg3);
        assert!(0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::guardian_set_index(&v0) == arg0.set_index, 1);
        assert!(0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::verify(&v0, &arg0.guardians, arg0.quorum), 2);
        assert!(0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::emitter_chain(&v0) == arg0.emitter_chain, 3);
        assert!(0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::emitter_address(&v0) == arg0.emitter_address, 3);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::emitter_chain(&v0);
        0x1::vector::push_back<u8>(&mut v1, ((v2 >> 8) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((v2 & 255) as u8));
        let v3 = 0;
        while (v3 < 8) {
            0x1::vector::push_back<u8>(&mut v1, ((0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::sequence(&v0) >> 8 * (7 - v3) & 255) as u8));
            v3 = v3 + 1;
        };
        let v4 = 0x2::hash::keccak256(&v1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.processed, v4), 4);
        0x2::table::add<vector<u8>, bool>(&mut arg0.processed, v4, true);
        let v5 = 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::payload_dest8(&v0);
        0x1::vector::append<u8>(&mut v5, 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::payload_source_token(&v0));
        0x3c549f2ed5cd05b87faafff02e6f7769dd51cc703090df0e962c5a8e1bbc937b::core::submit_verified_deposit(arg1, arg2, v4, arg4, 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::payload_amount(&v0), v5);
    }

    public fun verify_and_submit_v2(arg0: &mut GuardianSetV2, arg1: &mut 0x3c549f2ed5cd05b87faafff02e6f7769dd51cc703090df0e962c5a8e1bbc937b::core::BridgeCore, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::parse(arg2);
        assert!(0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::guardian_set_index(&v0) == arg0.set_index, 1);
        assert!(0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::verify(&v0, &arg0.guardians, arg0.quorum), 2);
        assert!(0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::emitter_chain(&v0) == arg0.emitter_chain, 3);
        assert!(0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::emitter_address(&v0) == arg0.emitter_address, 3);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::emitter_chain(&v0);
        0x1::vector::push_back<u8>(&mut v1, ((v2 >> 8) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((v2 & 255) as u8));
        let v3 = 0;
        while (v3 < 8) {
            0x1::vector::push_back<u8>(&mut v1, ((0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::sequence(&v0) >> 8 * (7 - v3) & 255) as u8));
            v3 = v3 + 1;
        };
        let v4 = 0x2::hash::keccak256(&v1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.processed, v4), 4);
        0x2::table::add<vector<u8>, bool>(&mut arg0.processed, v4, true);
        let v5 = 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::payload_dest8(&v0);
        0x1::vector::append<u8>(&mut v5, 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::payload_source_token(&v0));
        0x3c549f2ed5cd05b87faafff02e6f7769dd51cc703090df0e962c5a8e1bbc937b::core::submit_verified_deposit(arg1, &arg0.verifier_cap, v4, arg3, 0xc8028bdc9e7cdc354d631894019e21ef7606d00b9e0c81242a69cd1305cd54b5::vaa::payload_amount(&v0), v5);
    }

    // decompiled from Move bytecode v7
}

