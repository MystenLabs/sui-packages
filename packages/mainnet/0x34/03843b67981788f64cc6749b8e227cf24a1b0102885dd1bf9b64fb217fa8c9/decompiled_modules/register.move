module 0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::register {
    struct REGISTER has drop {
        dummy_field: bool,
    }

    struct IntentMessage<T0: copy + drop> has copy, drop {
        intent: u8,
        timestamp_ms: u64,
        data: T0,
    }

    struct AgentRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        registrations: 0x2::table::Table<u64, address>,
        latest_timestamp: u64,
    }

    struct AgentProfile has copy, drop {
        name: 0x1::string::String,
        role: 0x1::string::String,
        description: 0x1::string::String,
        addr: address,
    }

    struct AgentRegistered has copy, drop {
        registry: 0x2::object::ID,
        addr: address,
        timestamp_ms: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
    }

    fun create_registry<T0>(arg0: &mut 0x2::tx_context::TxContext) : AgentRegistry<T0> {
        let v0 = AgentRegistry<T0>{
            id               : 0x2::object::new(arg0),
            registrations    : 0x2::table::new<u64, address>(arg0),
            latest_timestamp : 0,
        };
        let v1 = RegistryCreated{registry_id: 0x2::object::id<AgentRegistry<T0>>(&v0)};
        0x2::event::emit<RegistryCreated>(v1);
        v0
    }

    fun init(arg0: REGISTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::enclave::new_cap<REGISTER>(arg0, arg1);
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::enclave::create_enclave_config<REGISTER>(&v0, 0x1::string::utf8(b"Polius Agent Registry Enclave"), x"3aa0e6e6ed7d8301655fced7e6ddcc443a3e57bf62f070caa6becf337069e859c0f03d68136440ff1cab8adefd20634c", x"b0d319fa64f9c2c9d7e9187bc21001ddacfab4077e737957fa1b8b97cc993bed43a79019aebfd40ee5f6f213147909f8", x"fdb2295dc5d9b67a653ed5f3ead5fc8166ec3cae1de1c7c6f31c3b43b2eb26ab5d063f414f3d2b93163426805dfe057e", x"94a33ba1298c64a16a1f4c9cc716525c86497017e09dd976afcaf812b0e2a3e8ba04ff6954167ad69a6413a1e6e44621", arg1);
        0x2::transfer::public_transfer<0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::enclave::Cap<REGISTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun initialize_registry(arg0: &mut 0x2::tx_context::TxContext) {
        share_registry<REGISTER>(create_registry<REGISTER>(arg0));
    }

    public fun is_registered<T0>(arg0: &AgentRegistry<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, address>(&arg0.registrations, arg1)
    }

    public fun latest_timestamp<T0>(arg0: &AgentRegistry<T0>) : u64 {
        arg0.latest_timestamp
    }

    entry fun register_agent(arg0: &mut AgentRegistry<REGISTER>, arg1: &0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::enclave::Enclave<REGISTER>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: u64, arg7: vector<u8>) {
        verify_and_register<REGISTER>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun registered_address<T0>(arg0: &AgentRegistry<T0>, arg1: u64) : address {
        *0x2::table::borrow<u64, address>(&arg0.registrations, arg1)
    }

    fun share_registry<T0>(arg0: AgentRegistry<T0>) {
        0x2::transfer::share_object<AgentRegistry<T0>>(arg0);
    }

    fun verify_and_register<T0: drop>(arg0: &mut AgentRegistry<T0>, arg1: &0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::enclave::Enclave<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: u64, arg7: vector<u8>) {
        let v0 = AgentProfile{
            name        : arg2,
            role        : arg3,
            description : arg4,
            addr        : arg5,
        };
        let v1 = IntentMessage<AgentProfile>{
            intent       : 0,
            timestamp_ms : arg6,
            data         : v0,
        };
        let v2 = 0x1::bcs::to_bytes<IntentMessage<AgentProfile>>(&v1);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg7, 0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::enclave::pk<T0>(arg1), &v2, 1), 0);
        assert!(!0x2::table::contains<u64, address>(&arg0.registrations, arg6), 1);
        0x2::table::add<u64, address>(&mut arg0.registrations, arg6, arg5);
        if (arg6 > arg0.latest_timestamp) {
            arg0.latest_timestamp = arg6;
        };
        let v3 = AgentRegistered{
            registry     : *0x2::object::uid_as_inner(&arg0.id),
            addr         : arg5,
            timestamp_ms : arg6,
        };
        0x2::event::emit<AgentRegistered>(v3);
    }

    // decompiled from Move bytecode v7
}

