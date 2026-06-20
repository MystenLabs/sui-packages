module 0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::events {
    struct WorldCreated has copy, drop {
        env: 0x2::object::ID,
        owner: address,
    }

    struct EnvRegistered has copy, drop {
        env: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        tags: vector<0x1::string::String>,
        artifact_uri: 0x1::string::String,
    }

    struct EnvMetadataUpdated has copy, drop {
        env: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        tags: vector<0x1::string::String>,
        artifact_uri: 0x1::string::String,
    }

    struct RegistryCreated has copy, drop {
        registry: 0x2::object::ID,
        environment: 0x2::object::ID,
        creator: address,
    }

    struct CheckpointPublished has copy, drop {
        registry: 0x2::object::ID,
        version: u64,
        walrus_blob_id: 0x1::string::String,
        pass_rate_bps: u64,
    }

    struct InferencePaid has copy, drop {
        registry: 0x2::object::ID,
        buyer: address,
        version: u64,
        theorem_id: u64,
        amount: u64,
        to_env: u64,
        to_registry: u64,
    }

    struct InferenceVerified has copy, drop {
        registry: 0x2::object::ID,
        buyer: address,
        version: u64,
        task_id: u64,
        pass_bps: u64,
        judge0_token: 0x1::string::String,
        output_hash: vector<u8>,
    }

    public(friend) fun emit_checkpoint_published(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: u64) {
        let v0 = CheckpointPublished{
            registry       : arg0,
            version        : arg1,
            walrus_blob_id : arg2,
            pass_rate_bps  : arg3,
        };
        0x2::event::emit<CheckpointPublished>(v0);
    }

    public(friend) fun emit_env_metadata_updated(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: 0x1::string::String) {
        let v0 = EnvMetadataUpdated{
            env          : arg0,
            name         : arg1,
            description  : arg2,
            tags         : arg3,
            artifact_uri : arg4,
        };
        0x2::event::emit<EnvMetadataUpdated>(v0);
    }

    public(friend) fun emit_env_registered(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: 0x1::string::String) {
        let v0 = EnvRegistered{
            env          : arg0,
            owner        : arg1,
            name         : arg2,
            description  : arg3,
            tags         : arg4,
            artifact_uri : arg5,
        };
        0x2::event::emit<EnvRegistered>(v0);
    }

    public(friend) fun emit_inference_paid(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = InferencePaid{
            registry    : arg0,
            buyer       : arg1,
            version     : arg2,
            theorem_id  : arg3,
            amount      : arg4,
            to_env      : arg5,
            to_registry : arg6,
        };
        0x2::event::emit<InferencePaid>(v0);
    }

    public(friend) fun emit_inference_verified(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: vector<u8>) {
        let v0 = InferenceVerified{
            registry     : arg0,
            buyer        : arg1,
            version      : arg2,
            task_id      : arg3,
            pass_bps     : arg4,
            judge0_token : arg5,
            output_hash  : arg6,
        };
        0x2::event::emit<InferenceVerified>(v0);
    }

    public(friend) fun emit_registry_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = RegistryCreated{
            registry    : arg0,
            environment : arg1,
            creator     : arg2,
        };
        0x2::event::emit<RegistryCreated>(v0);
    }

    public(friend) fun emit_world_created(arg0: 0x2::object::ID, arg1: address) {
        let v0 = WorldCreated{
            env   : arg0,
            owner : arg1,
        };
        0x2::event::emit<WorldCreated>(v0);
    }

    // decompiled from Move bytecode v7
}

