module 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid {
    struct ProofOfUID {
        from_uid: 0x2::object::ID,
        from_type: 0x1::option::Option<0x1::type_name::TypeName>,
        stamps: 0x2::vec_map::VecMap<0x2::object::ID, vector<u8>>,
    }

    public fun type_name(arg0: &ProofOfUID) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.from_type
    }

    public fun consume(arg0: ProofOfUID, arg1: &0x2::object::UID) : 0x2::vec_map::VecMap<0x2::object::ID, vector<u8>> {
        let ProofOfUID {
            from_uid  : v0,
            from_type : _,
            stamps    : v2,
        } = arg0;
        assert!(0x2::object::uid_to_inner(arg1) == v0, 13906834350437040127);
        v2
    }

    public fun created_from(arg0: &ProofOfUID) : 0x2::object::ID {
        arg0.from_uid
    }

    public fun has_stamp(arg0: &ProofOfUID, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, vector<u8>>(&arg0.stamps, &arg1)
    }

    public fun new(arg0: &0x2::object::UID) : ProofOfUID {
        ProofOfUID{
            from_uid  : 0x2::object::uid_to_inner(arg0),
            from_type : 0x1::option::none<0x1::type_name::TypeName>(),
            stamps    : 0x2::vec_map::empty<0x2::object::ID, vector<u8>>(),
        }
    }

    public fun new_with_type<T0: key>(arg0: &0x2::object::UID, arg1: &T0) : ProofOfUID {
        assert!(0x2::object::uid_to_inner(arg0) == 0x2::object::id<T0>(arg1), 13906834307487367167);
        ProofOfUID{
            from_uid  : 0x2::object::uid_to_inner(arg0),
            from_type : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()),
            stamps    : 0x2::vec_map::empty<0x2::object::ID, vector<u8>>(),
        }
    }

    public fun stamp(arg0: &mut ProofOfUID, arg1: &0x2::object::UID) {
        stamp_with_data(arg0, arg1, 0x1::vector::empty<u8>());
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

    // decompiled from Move bytecode v6
}

