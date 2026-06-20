module 0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::environment {
    struct EnvironmentCap has store, key {
        id: 0x2::object::UID,
        env: 0x2::object::ID,
    }

    struct Environment has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        tags: vector<0x1::string::String>,
        artifact_uri: 0x1::string::String,
        version: u64,
        fee_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        legit_until: u64,
    }

    public fun artifact_uri(arg0: &Environment) : 0x1::string::String {
        arg0.artifact_uri
    }

    fun assert_version(arg0: &Environment) {
        assert!(arg0.version == 1, 0);
    }

    public fun create_world(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : EnvironmentCap {
        create_world_internal(arg0, arg1, arg2, arg3, arg4)
    }

    entry fun create_world_entry(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_world_internal(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<EnvironmentCap>(v0, 0x2::tx_context::sender(arg4));
    }

    fun create_world_internal(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : EnvironmentCap {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Environment{
            id           : 0x2::object::new(arg4),
            owner        : v0,
            name         : arg0,
            description  : arg1,
            tags         : arg2,
            artifact_uri : arg3,
            version      : 1,
            fee_pool     : 0x2::balance::zero<0x2::sui::SUI>(),
            legit_until  : 0,
        };
        let v2 = 0x2::object::id<Environment>(&v1);
        let v3 = EnvironmentCap{
            id  : 0x2::object::new(arg4),
            env : v2,
        };
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::events::emit_world_created(v2, v0);
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::events::emit_env_registered(v2, v0, v1.name, v1.description, v1.tags, v1.artifact_uri);
        0x2::transfer::share_object<Environment>(v1);
        v3
    }

    public fun deposit_fees(arg0: &mut Environment, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun description(arg0: &Environment) : 0x1::string::String {
        arg0.description
    }

    public fun fee_pool_value(arg0: &Environment) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_pool)
    }

    public fun legit_until(arg0: &Environment) : u64 {
        arg0.legit_until
    }

    public fun migrate(arg0: &mut Environment, arg1: &EnvironmentCap) {
        assert!(arg1.env == 0x2::object::id<Environment>(arg0), 1);
        assert!(arg0.version < 1, 0);
        arg0.version = 1;
    }

    public fun name(arg0: &Environment) : 0x1::string::String {
        arg0.name
    }

    public fun owner(arg0: &Environment) : address {
        arg0.owner
    }

    entry fun ping(arg0: &0x2::tx_context::TxContext) {
    }

    public fun publish_artifact(arg0: &mut Environment, arg1: &EnvironmentCap, arg2: 0x1::string::String) {
        assert_version(arg0);
        assert!(arg1.env == 0x2::object::id<Environment>(arg0), 1);
        arg0.artifact_uri = arg2;
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::events::emit_env_metadata_updated(0x2::object::id<Environment>(arg0), arg0.name, arg0.description, arg0.tags, arg0.artifact_uri);
    }

    public fun tags(arg0: &Environment) : vector<0x1::string::String> {
        arg0.tags
    }

    public fun update_metadata(arg0: &mut Environment, arg1: &EnvironmentCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>) {
        assert_version(arg0);
        assert!(arg1.env == 0x2::object::id<Environment>(arg0), 1);
        arg0.name = arg2;
        arg0.description = arg3;
        arg0.tags = arg4;
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::events::emit_env_metadata_updated(0x2::object::id<Environment>(arg0), arg0.name, arg0.description, arg0.tags, arg0.artifact_uri);
    }

    public fun version(arg0: &Environment) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

