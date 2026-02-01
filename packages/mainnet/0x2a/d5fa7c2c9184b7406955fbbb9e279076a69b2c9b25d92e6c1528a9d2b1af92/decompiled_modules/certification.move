module 0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::certification {
    struct CertificationIssued has copy, drop {
        certification_id: 0x2::object::ID,
        skill_id: 0x2::object::ID,
        skill_version: 0x1::string::String,
        certifier_agent: 0x2::object::ID,
        certification_type: 0x1::string::String,
        certified_at: u64,
    }

    struct CertificationRevoked has copy, drop {
        certification_id: 0x2::object::ID,
        revoked_at: u64,
    }

    struct Certification has key {
        id: 0x2::object::UID,
        skill_id: 0x2::object::ID,
        skill_version: 0x1::string::String,
        certifier_agent: 0x2::object::ID,
        certification_type: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        certified_at: u64,
        expires_at: u64,
        revoked: bool,
        revoked_at: 0x1::option::Option<u64>,
    }

    public fun id(arg0: &Certification) : 0x2::object::ID {
        0x2::object::id<Certification>(arg0)
    }

    public fun certification_type(arg0: &Certification) : 0x1::string::String {
        arg0.certification_type
    }

    public fun certified_at(arg0: &Certification) : u64 {
        arg0.certified_at
    }

    public fun certifier_agent(arg0: &Certification) : 0x2::object::ID {
        arg0.certifier_agent
    }

    public fun expires_at(arg0: &Certification) : u64 {
        arg0.expires_at
    }

    public fun is_revoked(arg0: &Certification) : bool {
        arg0.revoked
    }

    public fun is_valid(arg0: &Certification, arg1: u64) : bool {
        if (arg0.revoked) {
            return false
        };
        if (arg0.expires_at > 0 && arg1 > arg0.expires_at) {
            return false
        };
        true
    }

    public fun issue(arg0: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::skill::Skill, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg0) == 0x2::tx_context::sender(arg5), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg0) != 0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::skill::agent_id(arg1), 1);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v1 = 0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg0);
        let v2 = 0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::skill::Skill>(arg1);
        let v3 = Certification{
            id                 : 0x2::object::new(arg5),
            skill_id           : v2,
            skill_version      : 0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::skill::version(arg1),
            certifier_agent    : v1,
            certification_type : arg2,
            metadata_uri       : arg3,
            certified_at       : v0,
            expires_at         : arg4,
            revoked            : false,
            revoked_at         : 0x1::option::none<u64>(),
        };
        let v4 = CertificationIssued{
            certification_id   : 0x2::object::id<Certification>(&v3),
            skill_id           : v2,
            skill_version      : v3.skill_version,
            certifier_agent    : v1,
            certification_type : v3.certification_type,
            certified_at       : v0,
        };
        0x2::event::emit<CertificationIssued>(v4);
        0x2::transfer::share_object<Certification>(v3);
    }

    public fun metadata_uri(arg0: &Certification) : 0x1::string::String {
        arg0.metadata_uri
    }

    public fun revoke(arg0: &mut Certification, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg1) == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg1) == arg0.certifier_agent, 25);
        assert!(!arg0.revoked, 24);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        arg0.revoked = true;
        arg0.revoked_at = 0x1::option::some<u64>(v0);
        let v1 = CertificationRevoked{
            certification_id : 0x2::object::id<Certification>(arg0),
            revoked_at       : v0,
        };
        0x2::event::emit<CertificationRevoked>(v1);
    }

    public fun skill_id(arg0: &Certification) : 0x2::object::ID {
        arg0.skill_id
    }

    public fun skill_version(arg0: &Certification) : 0x1::string::String {
        arg0.skill_version
    }

    // decompiled from Move bytecode v6
}

