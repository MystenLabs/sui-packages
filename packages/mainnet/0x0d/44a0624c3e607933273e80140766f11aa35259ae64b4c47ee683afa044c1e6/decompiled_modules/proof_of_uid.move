module 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid {
    struct ProofOfUID {
        from_uid: 0x2::object::ID,
        from_type: 0x1::option::Option<0x1::type_name::TypeName>,
        stamps: 0x2::vec_map::VecMap<0x2::object::ID, vector<u8>>,
    }

    struct UIDRequirements {
        proof: ProofOfUID,
        remaining: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun type_name(arg0: &ProofOfUID) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.from_type
    }

    public fun complete(arg0: UIDRequirements) : 0x2::vec_map::VecMap<0x2::object::ID, vector<u8>> {
        let UIDRequirements {
            proof     : v0,
            remaining : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x2::vec_set::is_empty<0x2::object::ID>(&v2), 13906834818588606467);
        let ProofOfUID {
            from_uid  : _,
            from_type : _,
            stamps    : v5,
        } = v0;
        v5
    }

    public fun consume(arg0: ProofOfUID, arg1: &0x2::object::UID) : 0x2::vec_map::VecMap<0x2::object::ID, vector<u8>> {
        let ProofOfUID {
            from_uid  : v0,
            from_type : _,
            stamps    : v2,
        } = arg0;
        assert!(0x2::object::uid_to_inner(arg1) == v0, 13906834483581026303);
        v2
    }

    public fun created_from(arg0: &ProofOfUID) : 0x2::object::ID {
        arg0.from_uid
    }

    public fun has_stamp(arg0: &ProofOfUID, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, vector<u8>>(&arg0.stamps, &arg1)
    }

    public fun has_stamp_with_data(arg0: &ProofOfUID, arg1: 0x2::object::ID, arg2: &vector<u8>) : bool {
        0x2::vec_map::contains<0x2::object::ID, vector<u8>>(&arg0.stamps, &arg1) && 0x2::vec_map::get<0x2::object::ID, vector<u8>>(&arg0.stamps, &arg1) == arg2
    }

    public fun into_requirements(arg0: ProofOfUID, arg1: &0x2::object::UID, arg2: 0x2::vec_set::VecSet<0x2::object::ID>) : UIDRequirements {
        assert!(arg0.from_uid == 0x2::object::uid_to_inner(arg1), 13906834715509260289);
        UIDRequirements{
            proof     : arg0,
            remaining : arg2,
        }
    }

    public fun new(arg0: &0x2::object::UID) : ProofOfUID {
        ProofOfUID{
            from_uid  : 0x2::object::uid_to_inner(arg0),
            from_type : 0x1::option::none<0x1::type_name::TypeName>(),
            stamps    : 0x2::vec_map::empty<0x2::object::ID, vector<u8>>(),
        }
    }

    public fun new_with_type<T0: key>(arg0: &0x2::object::UID, arg1: &T0) : ProofOfUID {
        assert!(0x2::object::uid_to_inner(arg0) == 0x2::object::id<T0>(arg1), 13906834432041418751);
        ProofOfUID{
            from_uid  : 0x2::object::uid_to_inner(arg0),
            from_type : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()),
            stamps    : 0x2::vec_map::empty<0x2::object::ID, vector<u8>>(),
        }
    }

    public fun proof(arg0: &UIDRequirements) : &ProofOfUID {
        &arg0.proof
    }

    public fun read_stamp_data_of_id(arg0: &ProofOfUID, arg1: 0x2::object::ID) : 0x1::option::Option<vector<u8>> {
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u8>>(&arg0.stamps, &arg1)) {
            return 0x1::option::none<vector<u8>>()
        };
        0x1::option::some<vector<u8>>(*0x2::vec_map::get<0x2::object::ID, vector<u8>>(&arg0.stamps, &arg1))
    }

    public fun satisfy(arg0: &mut UIDRequirements, arg1: &0x2::object::UID) {
        let v0 = 0x2::object::uid_to_inner(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.remaining, &v0)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.remaining, &v0);
            let v1 = &mut arg0.proof;
            stamp(v1, arg1);
        };
    }

    public fun stamp(arg0: &mut ProofOfUID, arg1: &0x2::object::UID) {
        stamp_with_data(arg0, arg1, b"");
    }

    public fun stamp_with_data(arg0: &mut ProofOfUID, arg1: &0x2::object::UID, arg2: vector<u8>) {
        0x2::vec_map::insert<0x2::object::ID, vector<u8>>(&mut arg0.stamps, 0x2::object::uid_to_inner(arg1), arg2);
    }

    public fun stamps(arg0: &ProofOfUID) : &0x2::vec_map::VecMap<0x2::object::ID, vector<u8>> {
        &arg0.stamps
    }

    public fun stamps_len(arg0: &ProofOfUID) : u64 {
        0x2::vec_map::length<0x2::object::ID, vector<u8>>(&arg0.stamps)
    }

    public fun unstamp(arg0: &mut ProofOfUID, arg1: &0x2::object::UID) {
        let v0 = 0x2::object::uid_to_inner(arg1);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, vector<u8>>(&mut arg0.stamps, &v0);
    }

    // decompiled from Move bytecode v7
}

