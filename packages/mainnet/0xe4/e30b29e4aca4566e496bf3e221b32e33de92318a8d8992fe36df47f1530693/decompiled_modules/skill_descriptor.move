module 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::skill_descriptor {
    struct SkillDescriptor has store, key {
        id: 0x2::object::UID,
        owner: address,
        skill_id: vector<u8>,
        walrus_manifest_blob: vector<u8>,
        manifest_hash: vector<u8>,
        mvr_package_name: vector<u8>,
        version: vector<u8>,
        required_capabilities: vector<vector<u8>>,
        dependencies: vector<vector<u8>>,
        seal_policy_id: vector<u8>,
        suins_subname: vector<u8>,
    }

    struct SkillPublished has copy, drop {
        descriptor: 0x2::object::ID,
        owner: address,
        skill_id: vector<u8>,
        manifest_hash: vector<u8>,
    }

    struct SkillUpdated has copy, drop {
        descriptor: 0x2::object::ID,
        version: vector<u8>,
    }

    struct SkillSealPolicySet has copy, drop {
        descriptor: 0x2::object::ID,
        seal_policy_id: vector<u8>,
    }

    public fun create(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) : SkillDescriptor {
        let v0 = SkillDescriptor{
            id                    : 0x2::object::new(arg7),
            owner                 : 0x2::tx_context::sender(arg7),
            skill_id              : arg0,
            walrus_manifest_blob  : arg1,
            manifest_hash         : arg2,
            mvr_package_name      : arg3,
            version               : arg4,
            required_capabilities : arg6,
            dependencies          : vector[],
            seal_policy_id        : b"",
            suins_subname         : arg5,
        };
        let v1 = SkillPublished{
            descriptor    : 0x2::object::id<SkillDescriptor>(&v0),
            owner         : 0x2::tx_context::sender(arg7),
            skill_id      : arg0,
            manifest_hash : arg2,
        };
        0x2::event::emit<SkillPublished>(v1);
        v0
    }

    public fun dependencies(arg0: &SkillDescriptor) : vector<vector<u8>> {
        arg0.dependencies
    }

    public fun manifest_hash(arg0: &SkillDescriptor) : vector<u8> {
        arg0.manifest_hash
    }

    public fun mvr_package_name(arg0: &SkillDescriptor) : vector<u8> {
        arg0.mvr_package_name
    }

    public fun owner(arg0: &SkillDescriptor) : address {
        arg0.owner
    }

    public fun required_capabilities(arg0: &SkillDescriptor) : vector<vector<u8>> {
        arg0.required_capabilities
    }

    public fun seal_policy_id(arg0: &SkillDescriptor) : vector<u8> {
        arg0.seal_policy_id
    }

    public fun set_dependencies(arg0: &mut SkillDescriptor, arg1: vector<vector<u8>>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.dependencies = arg1;
    }

    public fun set_required_capabilities(arg0: &mut SkillDescriptor, arg1: vector<vector<u8>>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.required_capabilities = arg1;
    }

    public fun set_seal_policy(arg0: &mut SkillDescriptor, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.seal_policy_id = arg1;
        let v0 = SkillSealPolicySet{
            descriptor     : 0x2::object::id<SkillDescriptor>(arg0),
            seal_policy_id : arg1,
        };
        0x2::event::emit<SkillSealPolicySet>(v0);
    }

    public fun set_suins_subname(arg0: &mut SkillDescriptor, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.suins_subname = arg1;
    }

    public fun skill_id(arg0: &SkillDescriptor) : vector<u8> {
        arg0.skill_id
    }

    public fun suins_subname(arg0: &SkillDescriptor) : vector<u8> {
        arg0.suins_subname
    }

    public fun update(arg0: &mut SkillDescriptor, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        arg0.walrus_manifest_blob = arg1;
        arg0.manifest_hash = arg2;
        arg0.version = arg3;
        let v0 = SkillUpdated{
            descriptor : 0x2::object::id<SkillDescriptor>(arg0),
            version    : arg3,
        };
        0x2::event::emit<SkillUpdated>(v0);
    }

    public fun version(arg0: &SkillDescriptor) : vector<u8> {
        arg0.version
    }

    public fun walrus_manifest_blob(arg0: &SkillDescriptor) : vector<u8> {
        arg0.walrus_manifest_blob
    }

    // decompiled from Move bytecode v7
}

