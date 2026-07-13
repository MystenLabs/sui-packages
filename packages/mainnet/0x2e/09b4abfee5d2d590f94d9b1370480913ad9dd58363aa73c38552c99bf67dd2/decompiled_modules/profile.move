module 0x2e09b4abfee5d2d590f94d9b1370480913ad9dd58363aa73c38552c99bf67dd2::profile {
    struct Profile has store, key {
        id: 0x2::object::UID,
        owner: address,
        avatar: 0x1::string::String,
        config: 0x1::string::String,
        updated_ms: u64,
    }

    struct ProfileUpdated has copy, drop {
        profile: address,
        owner: address,
        updated_ms: u64,
    }

    public fun avatar(arg0: &Profile) : 0x1::string::String {
        arg0.avatar
    }

    fun check_lens(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        assert!(0x1::string::length(arg0) <= 512, 1);
        assert!(0x1::string::length(arg1) <= 1024, 1);
    }

    public fun config(arg0: &Profile) : 0x1::string::String {
        arg0.config
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Profile {
        check_lens(&arg0, &arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::object::new(arg3);
        let v3 = Profile{
            id         : v2,
            owner      : v0,
            avatar     : arg0,
            config     : arg1,
            updated_ms : v1,
        };
        let v4 = ProfileUpdated{
            profile    : 0x2::object::uid_to_address(&v2),
            owner      : v0,
            updated_ms : v1,
        };
        0x2::event::emit<ProfileUpdated>(v4);
        v3
    }

    public fun owner(arg0: &Profile) : address {
        arg0.owner
    }

    public fun set(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0);
        check_lens(&arg1, &arg2);
        arg0.avatar = arg1;
        arg0.config = arg2;
        arg0.updated_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = ProfileUpdated{
            profile    : 0x2::object::uid_to_address(&arg0.id),
            owner      : arg0.owner,
            updated_ms : arg0.updated_ms,
        };
        0x2::event::emit<ProfileUpdated>(v0);
    }

    public fun updated_ms(arg0: &Profile) : u64 {
        arg0.updated_ms
    }

    // decompiled from Move bytecode v7
}

