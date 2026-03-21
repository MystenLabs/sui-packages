module 0x14fb8216d2bbd5ee30d1de9f0b1e274d0c04b760466dde17ec530ecdabd0386e::mvr_attestation {
    struct MVR_ATTESTATION has drop {
        dummy_field: bool,
    }

    struct ResolutionVerified has copy, drop {
        mvr_name: 0x1::string::String,
        resolved_address: address,
        version: u64,
        network: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ResolutionCache has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<0x1::string::String, CachedResolution>,
    }

    struct CachedResolution has drop, store {
        resolved_address: address,
        version: u64,
        network: 0x1::string::String,
        verified_at_ms: u64,
        enclave_pubkey: vector<u8>,
    }

    struct ProcessMessage has copy, drop {
        action: vector<u8>,
        network: vector<u8>,
        results: vector<ResolutionResultEntry>,
    }

    struct ResolutionResultEntry has copy, drop {
        mvr_name: vector<u8>,
        resolved_address: vector<u8>,
        version: u64,
    }

    public fun cached_address(arg0: &CachedResolution) : address {
        arg0.resolved_address
    }

    public fun cached_timestamp_ms(arg0: &CachedResolution) : u64 {
        arg0.verified_at_ms
    }

    public fun cached_version(arg0: &CachedResolution) : u64 {
        arg0.version
    }

    public fun has_resolution(arg0: &ResolutionCache, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, CachedResolution>(&arg0.entries, arg1)
    }

    fun init(arg0: MVR_ATTESTATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ResolutionCache{
            id      : 0x2::object::new(arg1),
            entries : 0x2::table::new<0x1::string::String, CachedResolution>(arg1),
        };
        0x2::transfer::share_object<ResolutionCache>(v0);
        0x2::transfer::public_transfer<0x14fb8216d2bbd5ee30d1de9f0b1e274d0c04b760466dde17ec530ecdabd0386e::enclave::Cap<MVR_ATTESTATION>>(0x14fb8216d2bbd5ee30d1de9f0b1e274d0c04b760466dde17ec530ecdabd0386e::enclave::new_cap<MVR_ATTESTATION>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun query_cache(arg0: &ResolutionCache, arg1: 0x1::string::String) : &CachedResolution {
        0x2::table::borrow<0x1::string::String, CachedResolution>(&arg0.entries, arg1)
    }

    public fun verify_and_store(arg0: &mut ResolutionCache, arg1: &0x14fb8216d2bbd5ee30d1de9f0b1e274d0c04b760466dde17ec530ecdabd0386e::enclave::Enclave<MVR_ATTESTATION>, arg2: u8, arg3: u64, arg4: ProcessMessage, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x14fb8216d2bbd5ee30d1de9f0b1e274d0c04b760466dde17ec530ecdabd0386e::enclave::verify_signature<MVR_ATTESTATION, ProcessMessage>(arg1, arg2, arg3, arg4, &arg5), 0);
        let v0 = 0x1::string::utf8(arg4.network);
        let v1 = 0;
        while (v1 < 0x1::vector::length<ResolutionResultEntry>(&arg4.results)) {
            let v2 = 0x1::vector::borrow<ResolutionResultEntry>(&arg4.results, v1);
            let v3 = 0x1::string::utf8(v2.mvr_name);
            let v4 = 0x2::address::from_bytes(v2.resolved_address);
            if (0x2::table::contains<0x1::string::String, CachedResolution>(&arg0.entries, v3)) {
                assert!(arg3 > 0x2::table::borrow<0x1::string::String, CachedResolution>(&arg0.entries, v3).verified_at_ms, 2);
                0x2::table::remove<0x1::string::String, CachedResolution>(&mut arg0.entries, v3);
            };
            let v5 = CachedResolution{
                resolved_address : v4,
                version          : v2.version,
                network          : v0,
                verified_at_ms   : arg3,
                enclave_pubkey   : *0x14fb8216d2bbd5ee30d1de9f0b1e274d0c04b760466dde17ec530ecdabd0386e::enclave::pk<MVR_ATTESTATION>(arg1),
            };
            0x2::table::add<0x1::string::String, CachedResolution>(&mut arg0.entries, v3, v5);
            let v6 = ResolutionVerified{
                mvr_name         : v3,
                resolved_address : v4,
                version          : v2.version,
                network          : v0,
                timestamp_ms     : arg3,
            };
            0x2::event::emit<ResolutionVerified>(v6);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

