module 0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::TimeStamping {
    struct StampInfo has store {
        timestamp: u64,
        users_signed: u64,
        is_public: bool,
        signers: 0x2::vec_set::VecSet<address>,
    }

    struct SignerInfo has copy, drop {
        signer: address,
        is_admitted: bool,
        signature_timestamp: u64,
    }

    struct DetailedStampInfo has copy, drop {
        is_public: bool,
        timestamp: u64,
        users_to_sign: u64,
        users_signed: u64,
        stamp_hash: vector<u8>,
        signers_info: vector<SignerInfo>,
    }

    struct StampTable has key {
        id: 0x2::object::UID,
        stamps: 0x2::table::Table<vector<u8>, StampInfo>,
        admin: address,
        is_paused: bool,
    }

    struct SignersTimestamps has key {
        id: 0x2::object::UID,
        data: 0x2::table::Table<address, 0x2::table::Table<vector<u8>, u64>>,
    }

    struct SignersStampHashes has key {
        id: 0x2::object::UID,
        data: 0x2::table::Table<address, 0x2::vec_set::VecSet<vector<u8>>>,
    }

    struct StampCreated has copy, drop {
        stamp_hash: vector<u8>,
        timestamp: u64,
        signers: vector<address>,
    }

    struct StampSigned has copy, drop {
        stamp_hash: vector<u8>,
        signer: address,
    }

    public entry fun create_stamp(arg0: vector<u8>, arg1: bool, arg2: vector<address>, arg3: &mut StampTable, arg4: &mut SignersTimestamps, arg5: &mut SignersStampHashes, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 1006);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1002);
        assert!(0x1::vector::length<address>(&arg2) > 0, 1005);
        assert!(!0x2::table::contains<vector<u8>, StampInfo>(&arg3.stamps, arg0), 1001);
        let v1 = 0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::HashVerifier::create_proof(&arg0, v0);
        assert!(0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::HashVerifier::verify_proof(0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::HashVerifier::get_hash(&v1), &arg0, v0), 1002);
        assert!(0x1::vector::length<address>(&arg2) > 0, 1005);
        let v2 = 0x2::vec_set::empty<address>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut v2, *0x1::vector::borrow<address>(&arg2, v3));
            v3 = v3 + 1;
        };
        if (!0x2::vec_set::contains<address>(&v2, &v0)) {
            0x2::vec_set::insert<address>(&mut v2, v0);
        };
        let v4 = StampInfo{
            timestamp    : 0x2::tx_context::epoch(arg6),
            users_signed : 0,
            is_public    : false,
            signers      : v2,
        };
        0x2::table::add<vector<u8>, StampInfo>(&mut arg3.stamps, arg0, v4);
        let v5 = StampCreated{
            stamp_hash : arg0,
            timestamp  : 0x2::tx_context::epoch(arg6),
            signers    : arg2,
        };
        0x2::event::emit<StampCreated>(v5);
        if (arg1 && 0x2::vec_set::contains<address>(&v2, &v0)) {
            sign(arg0, arg3, arg4, arg5, arg6);
        };
    }

    public fun get_hashes_by_user_address(arg0: &SignersStampHashes, arg1: address) : vector<vector<u8>> {
        let v0 = get_signer_hashes_const(arg0, arg1);
        if (v0 == 0x1::option::none<0x2::vec_set::VecSet<vector<u8>>>()) {
            0x1::vector::empty<vector<u8>>()
        } else {
            0x2::vec_set::into_keys<vector<u8>>(*0x1::option::borrow<0x2::vec_set::VecSet<vector<u8>>>(&v0))
        }
    }

    fun get_signer_hashes(arg0: &mut SignersStampHashes, arg1: address) : &mut 0x2::vec_set::VecSet<vector<u8>> {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.data, arg1)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.data, arg1, 0x2::vec_set::empty<vector<u8>>());
        };
        0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.data, arg1)
    }

    fun get_signer_hashes_const(arg0: &SignersStampHashes, arg1: address) : 0x1::option::Option<0x2::vec_set::VecSet<vector<u8>>> {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.data, arg1)) {
            0x1::option::some<0x2::vec_set::VecSet<vector<u8>>>(*0x2::table::borrow<address, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.data, arg1))
        } else {
            0x1::option::none<0x2::vec_set::VecSet<vector<u8>>>()
        }
    }

    public fun get_stamp_hash_by_bytes(arg0: vector<u8>) : vector<u8> {
        0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::Hash::hash_bytes(&arg0)
    }

    public fun get_stamp_info(arg0: &StampTable, arg1: &SignersTimestamps, arg2: &SignersStampHashes, arg3: vector<u8>) : DetailedStampInfo {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg3), 1003);
        let v0 = 0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg3);
        let v1 = 0x1::vector::empty<SignerInfo>();
        let v2 = &v0.signers;
        let v3 = 0x2::vec_set::into_keys<address>(*v2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v3)) {
            0x1::vector::push_back<SignerInfo>(&mut v1, get_user_info(arg1, arg2, *0x1::vector::borrow<address>(&v3, v4), arg3));
            v4 = v4 + 1;
        };
        let v5 = if (v0.is_public) {
            18446744073709551615
        } else {
            0x2::vec_set::size<address>(v2)
        };
        DetailedStampInfo{
            is_public     : v0.is_public,
            timestamp     : v0.timestamp,
            users_to_sign : v5,
            users_signed  : v0.users_signed,
            stamp_hash    : arg3,
            signers_info  : v1,
        }
    }

    public fun get_stamp_signers_count(arg0: &StampTable, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).users_signed
    }

    public fun get_user_info(arg0: &SignersTimestamps, arg1: &SignersStampHashes, arg2: address, arg3: vector<u8>) : SignerInfo {
        let v0 = get_signer_hashes_const(arg1, arg2);
        let v1 = 0x1::option::is_some<0x2::vec_set::VecSet<vector<u8>>>(&v0) && 0x2::vec_set::contains<vector<u8>>(0x1::option::borrow<0x2::vec_set::VecSet<vector<u8>>>(&v0), &arg3);
        let v2 = if (v1) {
            if (0x2::table::contains<address, 0x2::table::Table<vector<u8>, u64>>(&arg0.data, arg2)) {
                let v3 = 0x2::table::borrow<address, 0x2::table::Table<vector<u8>, u64>>(&arg0.data, arg2);
                if (0x2::table::contains<vector<u8>, u64>(v3, arg3)) {
                    *0x2::table::borrow<vector<u8>, u64>(v3, arg3)
                } else {
                    0
                }
            } else {
                0
            }
        } else {
            0
        };
        SignerInfo{
            signer              : arg2,
            is_admitted         : !v1,
            signature_timestamp : v2,
        }
    }

    fun get_user_timestamps(arg0: &mut SignersTimestamps, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut 0x2::table::Table<vector<u8>, u64> {
        if (!0x2::table::contains<address, 0x2::table::Table<vector<u8>, u64>>(&arg0.data, arg1)) {
            0x2::table::add<address, 0x2::table::Table<vector<u8>, u64>>(&mut arg0.data, arg1, 0x2::table::new<vector<u8>, u64>(arg2));
        };
        0x2::table::borrow_mut<address, 0x2::table::Table<vector<u8>, u64>>(&mut arg0.data, arg1)
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StampTable{
            id        : 0x2::object::new(arg0),
            stamps    : 0x2::table::new<vector<u8>, StampInfo>(arg0),
            admin     : 0x2::tx_context::sender(arg0),
            is_paused : false,
        };
        let v1 = SignersTimestamps{
            id   : 0x2::object::new(arg0),
            data : 0x2::table::new<address, 0x2::table::Table<vector<u8>, u64>>(arg0),
        };
        let v2 = SignersStampHashes{
            id   : 0x2::object::new(arg0),
            data : 0x2::table::new<address, 0x2::vec_set::VecSet<vector<u8>>>(arg0),
        };
        0x2::transfer::share_object<StampTable>(v0);
        0x2::transfer::share_object<SignersTimestamps>(v1);
        0x2::transfer::share_object<SignersStampHashes>(v2);
    }

    public entry fun pause(arg0: &mut StampTable, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1007);
        arg0.is_paused = true;
    }

    public entry fun sign(arg0: vector<u8>, arg1: &mut StampTable, arg2: &mut SignersTimestamps, arg3: &mut SignersStampHashes, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 1006);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::tx_context::epoch(arg4);
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1002);
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg1.stamps, arg0), 1003);
        let v2 = 0x2::table::borrow_mut<vector<u8>, StampInfo>(&mut arg1.stamps, arg0);
        let v3 = get_signer_hashes(arg3, v0);
        assert!(!0x2::vec_set::contains<vector<u8>>(v3, &arg0), 1004);
        assert!(!v2.is_public || 0x2::vec_set::contains<address>(&v2.signers, &v0), 1005);
        v2.users_signed = v2.users_signed + 1;
        0x2::table::add<vector<u8>, u64>(get_user_timestamps(arg2, v0, arg4), arg0, v1);
        0x2::vec_set::insert<vector<u8>>(v3, arg0);
        let v4 = StampSigned{
            stamp_hash : arg0,
            signer     : v0,
        };
        0x2::event::emit<StampSigned>(v4);
    }

    public entry fun unpause(arg0: &mut StampTable, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1007);
        arg0.is_paused = false;
    }

    // decompiled from Move bytecode v6
}

